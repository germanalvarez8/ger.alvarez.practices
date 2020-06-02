
document.addEventListener('DOMContentLoaded', () => {

const startbtn = document.querySelector('button');
const grid = document.querySelector('.grid');
const displaySquares = document.querySelectorAll('.previous-grid div');
const scoreDisplay = document.querySelector('.score-display');
const linesDisplay = document.querySelector('.lines-display')
let squares = Array.from(grid.querySelectorAll('div'));
const width = 10;
const height = 20;
let currentPosition = 4
let currentRotation = 0
let timerId;
let score = 0;
let lines = 0;
const colors = [
    'url(blocks/green_block.png)',
    'url(blocks/pink_block.png)',
    'url(blocks/purple_block.png)',
    'url(blocks/peach_block.png)',
    'url(blocks/yellow_block.png)',
    'url(blocks/blue_block.png)',
    'url(blocks/navy_block.png)'
  ]

//assign functions to keycodes
function control(e) {
    if(e.keyCode === 39) {
      moveright()
    } else if (e.keyCode ===38) {
      rotate()
    } else if (e.keyCode ===37) {
      moveleft()
    } else if (e.keyCode === 40) {
      moveDown()
    }
  };
document.addEventListener('keydown', control)

  //The Tetrominoes
  const lTetromino = [
    [1,width+1,width*2+1,2],
    [width,width+1,width+2,width*2+2],
    [1,width+1,width*2+1,width*2],
    [width,width*2,width*2+1,width*2+2]
  ]
  const clTetromino = [
    [1,width+1,width*2+1,0],
    [width+2,width*2,width*2+1,width*2+2],
    [1,width+1,width*2+1,width*2+2],
    [width,width+1,width+2,width*2]
  ]

  const zTetromino = [
    [0,width,width+1,width*2+1],
    [width+1, width+2,width*2,width*2+1],
    [0,width,width+1,width*2+1],
    [width+1, width+2,width*2,width*2+1]
  ]

  const czTetromino = [
    [1,width, width+1, width*2],
    [width, width+1,width*2+1,width*2+2],
    [1,width, width+1, width*2],
    [width, width+1,width*2+1,width*2+2]
  ]

  const tTetromino = [
    [1,width,width+1,width+2],
    [1,width+1,width+2,width*2+1],
    [width,width+1,width+2,width*2+1],
    [1,width,width+1,width*2+1]
  ]
  const oTetromino = [
    [0,1,width,width+1],
    [0,1,width,width+1],
    [0,1,width,width+1],
    [0,1,width,width+1]
  ]

  const iTetromino = [
    [1,width+1,width*2+1,width*3+1],
    [width,width+1,width+2,width+3],
    [1,width+1,width*2+1,width*3+1],
    [width,width+1,width+2,width+3]
  ]

  const theTetrominoes = [lTetromino,clTetromino,zTetromino ,czTetromino, tTetromino, oTetromino,iTetromino ]

  //Randomly Select Tetromino
  let random = Math.floor(Math.random()*theTetrominoes.length)
  let current = theTetrominoes[random][currentRotation]

  //draw the shape
  function draw() {
    current.forEach( index => {
      squares[currentPosition + index].classList.add('block')
      squares[currentPosition + index].style.backgroundImage = colors[random];
    })
  }
  //undraw the shape
  function undraw() {
    current.forEach( index => {
      squares[currentPosition + index].classList.remove('block')
      squares[currentPosition + index].style.backgroundImage = 'none'
    })
  }

  //move down on loop
  function moveDown() {
    undraw()
    currentPosition = currentPosition += width
    draw()
    freeze()
  }
  //move rigth
  //move left and prevent collisions with shapes moving left
  function moveright() {
    undraw()
    const isAtRightEdge = current.some(index => (currentPosition + index) % width === width - 1)
    if(!isAtRightEdge) currentPosition += 1
    if(current.some(index => squares[currentPosition + index].classList.contains('block2'))) {
      currentPosition -= 1
    }
    draw()
  }

  //move right and prevent collisions with shapes moving right
  function moveleft() {
    undraw()
    const isAtLeftEdge = current.some(index => (currentPosition + index) % width === 0)
    if(!isAtLeftEdge) currentPosition -= 1
    if(current.some(index => squares[currentPosition + index].classList.contains('block2'))) {
      currentPosition += 1
    }
    draw()
  }
  function freeze() {
    // if block has settled
    if(current.some(index => squares[currentPosition + index + width].classList.contains('block3') || squares[currentPosition + index + width].classList.contains('block2'))) {
        // make it block2
      current.forEach(index => squares[index + currentPosition].classList.add('block2'))
      current.forEach(index =>squares[currentPosition + index].style.backgroundImage = colors[0]);
      // start a new tetromino falling
      random = nextRandom
      nextRandom = Math.floor(Math.random() * theTetrominoes.length)
      current = theTetrominoes[random][currentRotation]
      currentPosition = 4
      draw()
      displayShape()
      gameOver();
      addScore();
    }
    }
  
  //add score
  function addScore() {
    for (currentIndex = 0; currentIndex < 199;currentIndex += width) {
      const row = [currentIndex,currentIndex+1,currentIndex+2,currentIndex+3,currentIndex+4,currentIndex+5,currentIndex+6,currentIndex+7,currentIndex+8,currentIndex+9]
      if(row.every(index => squares[index].classList.contains('block2'))) {
        score += 10
        lines +=1
        scoreDisplay.innerHTML = score
        linesDisplay.innerHTML = lines
        row.forEach(index => {
          squares[index].style.backgroundImage = 'none'
          squares[index].classList.remove('block2') || squares[index].classList.remove('block')

        })
        //splice array
        const squaresRemoved = squares.splice(currentIndex,width)
        squares = squaresRemoved.concat(squares)
        squares.forEach(cell => grid.appendChild(cell))
      }
    }
  }
  startbtn.addEventListener('click', ()=>{
    if(timerId){
        clearInterval(timerId);
        timerId=null;
    }else{
        draw();
        timerId = setInterval (moveDown, 800);
        nextRandom = Math.floor(Math.random()*theTetrominoes.length);
        displayShape();
    }})

  //game over
  function gameOver() {
    if(current.some(index => squares[currentPosition + index].classList.contains('block2'))) {
      scoreDisplay.innerHTML = 'end'
      clearInterval(timerId)
    }
  }

  function rotate(){
      undraw();
      currentRotation ++ ;
      if(currentRotation === current.length){
        currentRotation = 0;
      }
    current = theTetrominoes[random][currentRotation];
    draw();
  }
  //display previous piece
  const displayWidth = 4;
  let nextRandom = 0;
  let displayIndex = 0;

  const smallTetrominoes = [
    [1,displayWidth+1,displayWidth*2+1,2], /* lTetromino */
    [1,displayWidth+1,displayWidth*2+1,0], /*clTetromino*/
    [0,displayWidth,displayWidth+1,displayWidth*2+1],  /* zTetromino */
    [1,displayWidth, displayWidth+1, displayWidth*2],   /* czTetromino*/
    [1,displayWidth,displayWidth+1,displayWidth+2],    /* tTetromino */
    [0,1,displayWidth,displayWidth+1],     /* oTetromino */
    [1,displayWidth+1,displayWidth*2+1,displayWidth*3+1]  /* iTetromino */  
  ]
  function displayShape() {
    displaySquares.forEach(square => {
      square.classList.remove('block')
      square.style.backgroundImage = 'none'
    })
    smallTetrominoes[nextRandom].forEach( index => {
      displaySquares[displayIndex + index].classList.add('block')
      displaySquares[displayIndex + index].style.backgroundImage = colors[nextRandom]
    })
  }
})
