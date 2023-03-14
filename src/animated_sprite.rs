use rand::Rng;
use crate::constants;
use crate::html::Html;
use crate::point::Point;

pub struct AnimatedSprite {
    source_image: web_sys::HtmlImageElement,
    position: Point,
    frame_rate_min: f64,
    frame_rate_max: f64,
    ms_to_next_frame: f64,
    number_of_frames: i32,
    current_frame: i32,
}

fn next_frame_rate(min_rate: f64, max_rate: f64) -> f64 {
    let mut rng = rand::thread_rng();
    rng.gen_range(min_rate..max_rate)
}

impl AnimatedSprite {
    pub fn new(html: &Html, image_id: &str, position: Point, frame_rate_min: f64, frame_rate_max: f64, number_of_frames: i32, random_start_frame: bool) -> Self {
        let mut rng = rand::thread_rng();
        let current_frame =
            if random_start_frame {
                rng.gen_range(0..number_of_frames)
            } else {
                0
            };

        Self {
            source_image: html.get_image_by_id(image_id),
            position,
            frame_rate_min,
            frame_rate_max,
            ms_to_next_frame: next_frame_rate(frame_rate_min, frame_rate_max),
            number_of_frames,
            current_frame,
        }
    }

    pub fn update(&mut self, delta_time: f64) {
        self.ms_to_next_frame -= delta_time;

        if self.ms_to_next_frame <= 0.0 {
            self.ms_to_next_frame = next_frame_rate(self.frame_rate_min, self.frame_rate_max);

            self.current_frame += 1;

            if self.current_frame >= self.number_of_frames {
                self.current_frame = 0;
            }
        }
    }

    pub fn draw(&self, context: &web_sys::CanvasRenderingContext2d) {
        let source_x = self.current_frame as f64 * constants::TILE_SIZE;
        let source_y = 0.0;
        let frame_width = constants::TILE_SIZE;
        let frame_height = constants::TILE_SIZE;
        let position_x = self.position.x;
        let position_y = self.position.y;
        let scale_x = constants::TILE_SIZE;
        let scale_y = constants::TILE_SIZE;

        context
            .draw_image_with_html_image_element_and_sw_and_sh_and_dx_and_dy_and_dw_and_dh(
                &self.source_image,
                source_x,
                source_y,
                frame_width,
                frame_height,
                position_x,
                position_y,
                scale_x,
                scale_y,
            )
            .unwrap();
    }
}
