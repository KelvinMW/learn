Sure thing, here's a simple Javascript game for you!

```javascript
// Set up canvas
let canvas = document.getElementById('canvas');
let ctx = canvas.getContext('2d');

// Game objects
let ball = {
    x : canvas.width/2,
    y : canvas.height-30,
    radius : 10,
    color : '#003300',
    dx : 2,
    dy : -2
};

let paddle = {
    x : canvas.width/2,
    y : canvas.height-10,
    width : 75,
    height : 10,
    color : '#003300'
};

// Draw canvas
function draw() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    drawBall();
    drawPaddle();
}

// Draw ball
function drawBall() {
    ctx.beginPath();
    ctx.arc(ball.x, ball.y, ball.radius, 0, Math.PI*2);
    ctx.fillStyle = ball.color;
    ctx.fill();
    ctx.closePath();
}

// Draw paddle
function drawPaddle() {
    ctx.beginPath();
    ctx.rect(paddle.x, paddle.y, paddle.width, paddle.height);
    ctx.fillStyle = paddle.color;
    ctx.fill();
    ctx.closePath();
}

// Move paddle
function movePaddle() {
    document.addEventListener('keydown', (e) => {
        if (e.keyCode == 37) {
            paddle.x -= 7;
        } else if (e.keyCode == 39) {
            paddle.x += 7;
        }
    });
}

// Move ball
function moveBall() {
    ball.x += ball.dx;
    ball.y += ball.dy;

    // Bounce off walls
    if (ball.x + ball.radius > canvas.width || ball.x - ball.radius < 0) {
        ball.dx = -ball

