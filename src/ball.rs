pub struct Ball {
    pub x: f64,
    pub y: f64,
    pub w: f64,
    pub h: f64,
}

impl Ball {
    pub fn new() -> Self {
        Self {
            x: 0.0,
            y: 0.0,
            w: 16.0,
            h: 16.0,
        }
    }

    pub fn update(&mut self) {
        self.x += 1.0;
        self.y += 1.0;
    }

    pub fn draw(&self, ctx: &web_sys::CanvasRenderingContext2d) {
        ctx.set_fill_style(&"red".into());
        ctx.begin_path();

        ctx.fill_rect(self.x, self.y, self.w, self.h);

        ctx.close_path();
    }
}
