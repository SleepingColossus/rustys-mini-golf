use crate::constants;
use crate::html::Html;
use crate::point::Point;

pub struct SpriteSheet {
    source_image: web_sys::HtmlImageElement,
    number_of_columns: i32,
    number_of_rows: i32,
}

impl SpriteSheet {
    pub fn new(html: &Html, image_id: &str, number_of_columns: i32, number_of_rows: i32) -> Self {
        Self {
            source_image: html.get_image_by_id(image_id),
            number_of_columns,
            number_of_rows,
        }
    }

    pub fn draw_tile_at(
        &self,
        source_position: &Point,
        position: &Point,
        context: &web_sys::CanvasRenderingContext2d,
    ) {
        let source_x = source_position.x;
        let source_y = source_position.y;
        let frame_width = constants::TILE_SIZE;
        let frame_height = constants::TILE_SIZE;
        let position_x = position.x;
        let position_y = position.y;
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
