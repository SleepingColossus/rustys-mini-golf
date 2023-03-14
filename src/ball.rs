use crate::point::Point;

pub struct Ball {
    pub position: Point,
    pub last_position: Point,
    radius: f64,
    speed: Point,
}

impl Ball {
    pub fn new(starting_position: Point) -> Self {
        Self {
            position: starting_position,
            last_position: Point::zero(),
            radius: 5.0,
            speed: Point::new(1.0, 1.0),
        }
    }

    pub fn update(&mut self) {
        self.last_position = self.position;

        self.position.x += self.speed.x;
        self.position.y += self.speed.y;
    }

    pub fn draw(&self, ctx: &web_sys::CanvasRenderingContext2d) {
        ctx.set_fill_style(&"snow".into());
        ctx.begin_path();

        ctx.move_to(self.position.x, self.position.y);
        ctx.arc(self.position.x, self.position.y, self.radius, 0.0, std::f64::consts::PI * 2.0).unwrap();
        ctx.fill();

        ctx.close_path();
    }

    pub fn collide_horizontal(&mut self) {
        self.speed.y *= -1.0;
    }

    pub fn collide_vertical(&mut self) {
        self.speed.x *= -1.0;
    }

    pub fn revert_position(&mut self) {
        self.position = self.last_position;
    }
}
