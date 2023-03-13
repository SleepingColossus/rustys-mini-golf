use crate::ball::Ball;
use crate::level::Level;
use crate::point::Point;

pub struct Game {
    ball: Ball,
    level: Level,
    last_epoch: f64,
}

impl Game {
    pub fn new() -> Self {
        let tile_set = crate::sprite_sheet::SpriteSheet::new(&crate::html::Html::new(), "tileset", 6, 6);
        let tiles: Vec<Vec<i32>> = vec![
            vec![1,2,2,2,2,28,2,2,2,2,2,2,2,2,3],
            vec![7,8,8,8,8,18,8,8,8,8,8,8,8,8,9],
            vec![7,8,8,8,8,8,8,8,8,8,8,8,8,8,9],
            vec![7,8,8,8,8,6,8,8,8,8,8,8,8,8,9],
            vec![7,8,8,8,8,22,20,20,20,20,20,20,20,20,25],
            vec![7,8,8,8,8,8,8,8,8,8,8,8,8,8,9],
            vec![7,8,8,6,8,8,8,8,8,8,8,8,8,8,9],
            vec![7,8,19,24,21,8,8,8,8,8,8,8,8,8,9],
            vec![7,8,8,18,8,8,8,8,8,6,8,8,8,8,9],
            vec![7,8,8,8,8,8,8,8,8,12,8,8,8,8,9],
            vec![27,20,20,20,20,20,20,20,20,23,8,8,8,8,9],
            vec![7,8,8,8,8,8,8,8,8,8,8,8,8,8,9],
            vec![7,8,8,8,8,8,8,8,8,8,8,8,8,8,9],
            vec![7,8,8,8,8,8,8,8,8,8,8,8,8,8,9],
            vec![13,14,14,14,14,14,14,14,14,14,14,14,14,14,15],
        ];
        let level: Level = Level::new(0, tiles, Point::new(0.0, 0.0), tile_set);

        Self {
            ball: Ball::new(),
            level,
            last_epoch: 0.0,
        }
    }

    pub fn update(&mut self) {
        let epoch = js_sys::Date::now();
        let delta_time = epoch - self.last_epoch;

        self.level.update(delta_time);
        self.ball.update();

        self.last_epoch = epoch;
    }

    pub fn draw(
        &self,
        canvas: &web_sys::HtmlCanvasElement,
        context: &web_sys::CanvasRenderingContext2d,
    ) {
        // clear screen
        context.clear_rect(0.0, 0.0, canvas.width() as f64, canvas.height() as f64);

        self.level.draw(context);
        self.ball.draw(context);
    }
}
