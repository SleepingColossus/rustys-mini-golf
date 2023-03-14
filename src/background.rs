use wasm_bindgen::JsValue;
use crate::animated_sprite::AnimatedSprite;
use crate::constants;
use crate::html::Html;
use crate::point::Point;

pub struct Background {
    tiles: Vec<Vec<AnimatedSprite>>
}

impl Background {
    pub fn new(html: &Html) -> Self {
        let size_x = JsValue::as_f64(&html.window.inner_width().unwrap()).unwrap();
        let size_y = JsValue::as_f64(&html.window.inner_height().unwrap()).unwrap();

        &html.canvas_bg.set_width(size_x as u32);
        &html.canvas_bg.set_height(size_y as u32);

        let columns = 1 + (size_x / constants::TILE_SIZE) as i32;
        let rows = 1 + (size_y / constants::TILE_SIZE) as i32;

        let mut tiles: Vec<Vec<AnimatedSprite>> = Vec::new();

        for i in 0..columns {
            tiles.push(Vec::new());

            for j in 0..rows {
                let x = i as f64 * constants::TILE_SIZE;
                let y = j as f64 * constants::TILE_SIZE;
                let position = Point::new(x, y);

                let random_starting_paint = true;

                let animated_sprite = AnimatedSprite::new(html, "space", position, 1000.0, 2000.0,8, random_starting_paint);
                tiles[i as usize].push(animated_sprite);
            }
        }

        Self {
            tiles
        }
    }

    pub fn update(&mut self, delta_time: f64) {
        for row_of_tiles in &mut self.tiles {
            for tile in row_of_tiles {
                tile.update(delta_time);
            }
        }
    }

    pub fn draw(&mut self, context: &web_sys::CanvasRenderingContext2d) {
        for row_of_tiles in self.tiles.iter() {
            for tile in row_of_tiles.iter() {
                tile.draw(context);
            }
        }
    }
}
