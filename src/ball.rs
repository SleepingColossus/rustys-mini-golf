use crate::point::Point;

pub struct Ball {
    pub x: f64,
    pub y: f64,
    pub w: f64,
    pub h: f64,
    speed_x: f64,
    speed_y: f64,
    pub last_position: Point,
}

impl Ball {
    pub fn new(starting_position: Point) -> Self {
        Self {
            x: starting_position.x,
            y: starting_position.y,
            w: 16.0,
            h: 16.0,
            speed_x: 1.0,
            speed_y: 1.0,
            last_position: Point::zero()
        }
    }

    pub fn update(&mut self) {
        self.last_position.x = self.x;
        self.last_position.y = self.y;

        self.x += self.speed_x;
        self.y += self.speed_y;
    }

    pub fn draw(&self, ctx: &web_sys::CanvasRenderingContext2d) {
        ctx.set_fill_style(&"red".into());
        ctx.begin_path();

        ctx.fill_rect(self.x, self.y, self.w, self.h);

        ctx.close_path();
    }

    pub fn collide_horizontal(&mut self) {
        self.speed_y *= -1.0;
    }

    pub fn collide_vertical(&mut self) {
        self.speed_x *= -1.0;
    }
}
