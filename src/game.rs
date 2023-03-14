use crate::level::Level;
use crate::point::Point;

pub struct Game {
    level: Level,
}

impl Game {
    pub fn new() -> Self {
        let tile_set =
            crate::sprite_sheet::SpriteSheet::new(&crate::html::Html::new(), "tileset", 6);
        let tiles: Vec<Vec<i32>> = vec![
            vec![
                37, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 39,
            ],
            vec![43, 1, 2, 2, 2, 2, 28, 2, 2, 2, 2, 2, 2, 2, 2, 3, 45],
            vec![43, 7, 8, 8, 8, 8, 18, 8, 8, 8, 8, 8, 8, 8, 8, 9, 45],
            vec![43, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 45],
            vec![43, 7, 8, 8, 8, 8, 6, 8, 8, 8, 8, 8, 8, 8, 8, 9, 45],
            vec![
                43, 7, 8, 8, 8, 8, 22, 20, 20, 20, 20, 20, 20, 20, 20, 25, 45,
            ],
            vec![43, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 45],
            vec![43, 7, 8, 8, 6, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 45],
            vec![43, 7, 8, 19, 24, 21, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 45],
            vec![43, 7, 8, 8, 18, 8, 8, 8, 8, 8, 6, 8, 8, 8, 8, 9, 45],
            vec![43, 7, 8, 8, 8, 8, 8, 8, 8, 8, 12, 8, 8, 8, 8, 9, 45],
            vec![
                43, 27, 20, 20, 20, 20, 20, 20, 20, 20, 23, 8, 8, 8, 8, 9, 45,
            ],
            vec![43, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 45],
            vec![43, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 45],
            vec![43, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 45],
            vec![
                43, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 45,
            ],
            vec![
                49, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 51,
            ],
        ];
        let level: Level = Level::new(0, tiles, Point::new(100.0, 400.0), tile_set);

        Self { level }
    }

    pub fn update(&mut self, delta_time: f64) {
        self.level.update(delta_time);
    }

    pub fn draw(
        &self,
        canvas: &web_sys::HtmlCanvasElement,
        context: &web_sys::CanvasRenderingContext2d,
    ) {
        // clear screen
        context.clear_rect(0.0, 0.0, canvas.width() as f64, canvas.height() as f64);

        self.level.draw(context);
    }
}
