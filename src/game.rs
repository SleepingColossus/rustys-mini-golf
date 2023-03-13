use crate::ball::Ball;

pub struct Game {
    ball: Ball,
    elapsed_frames: i64,
}

impl Game {
    pub fn new() -> Self {
        Self {
            ball: Ball::new(),
            elapsed_frames: 0,
        }
    }

    pub fn update(&mut self) {
        self.elapsed_frames += 1;

        self.ball.update();
    }

    pub fn draw(
        &self,
        canvas: &web_sys::HtmlCanvasElement,
        context: &web_sys::CanvasRenderingContext2d,
    ) {
        // clear screen
        context.clear_rect(0.0, 0.0, canvas.width() as f64, canvas.height() as f64);

        self.ball.draw(context);
    }
}
