use crate::ball::Ball;
use crate::constants;
use crate::point::Point;
use crate::sprite_sheet::SpriteSheet;

const EMPTY_TILE_ID: i32 = 8;

pub struct Level {
    level_id: i32,
    tiles: Vec<Vec<i32>>,
    ball: Ball,
    tile_sheet: SpriteSheet,
}

impl Level {
    pub fn new(
        level_id: i32,
        tiles: Vec<Vec<i32>>,
        starting_position: Point,
        tile_sheet: SpriteSheet,
    ) -> Self {
        Self {
            level_id,
            tiles,
            ball: Ball::new(starting_position),
            tile_sheet,
        }
    }

    pub fn update(&mut self, delta_time: f64) {
        self.ball.update();

        for (i, row) in self.tiles.iter().enumerate() {
            for (j, tile) in row.iter().enumerate() {
                let position_x = j as f64 * constants::TILE_SIZE;
                let position_y = i as f64 * constants::TILE_SIZE;
                let position = Point::new(position_x, position_y);

                if *tile != EMPTY_TILE_ID {
                    let collision = self.is_ball_colliding(&position);

                    if collision {
                        //self.handle_collision(&position);
                        if self.ball.last_position.x > position.x
                            && self.ball.last_position.x < position.x + constants::TILE_SIZE
                        {
                            self.ball.collide_horizontal();
                        }

                        if self.ball.last_position.y > position.y
                            && self.ball.last_position.y < position.y + constants::TILE_SIZE
                        {
                            self.ball.collide_vertical();
                        }

                        self.ball.revert_position();
                    }
                }
            }
        }
    }

    pub fn draw(&self, context: &web_sys::CanvasRenderingContext2d) {
        for (i, row) in self.tiles.iter().enumerate() {
            for (j, tile) in row.iter().enumerate() {
                let position_x = j as f64 * constants::TILE_SIZE;
                let position_y = i as f64 * constants::TILE_SIZE;

                let position = Point::new(position_x, position_y);

                self.tile_sheet.draw_tile(*tile - 1, &position, context);
            }
        }

        self.ball.draw(context);
    }

    fn is_ball_colliding(&self, position: &Point) -> bool {
        // check for horizontal collision
        if self.ball.position.x > position.x
            && self.ball.position.x < position.x + constants::TILE_SIZE
        {
            // check for vertical collision
            if self.ball.position.y > position.y
                && self.ball.position.y < position.y + constants::TILE_SIZE
            {
                return true;
            }
        }

        false
    }

    // fn handle_collision(&mut self, position: &Point) {
    //     if self.ball.last_position.x > position.x && self.ball.last_position.x < position.x + constants::TILE_SIZE {
    //         self.ball.collide_horizontal();
    //     }
    //
    //     if self.ball.last_position.y > position.y && self.ball.last_position.y < position.y + constants::TILE_SIZE {
    //         self.ball.collide_vertical();
    //     }
    // }
}
