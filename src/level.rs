use crate::constants;
use crate::point::Point;
use crate::sprite_sheet::SpriteSheet;

pub struct Level {
    level_id: i32,
    tiles: Vec<Vec<i32>>,
    starting_position: Point,
    tile_sheet: SpriteSheet,
}

impl Level {
    pub fn new(level_id: i32, tiles: Vec<Vec<i32>>, starting_position: Point, tile_sheet: SpriteSheet) -> Self {
        Self {
            level_id,
            tiles,
            starting_position,
            tile_sheet,
        }
    }

    pub fn update(&self, delta_time: f64) {

    }

    pub fn draw(&self, context: &web_sys::CanvasRenderingContext2d) {
        for (i, row) in self.tiles.iter().enumerate() {
            for (j, tile) in row.iter().enumerate() {
                let position_x = j as f64 * constants::TILE_SIZE;
                let position_y = i as f64 * constants::TILE_SIZE;

                let position = Point::new(position_x, position_y);

                self.tile_sheet.draw_tile(*tile-1, &position, context);
            }
        }
    }
}
