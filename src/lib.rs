use std::cell::RefCell;
use std::rc::Rc;
use wasm_bindgen::prelude::*;
use wasm_bindgen::JsCast;

struct Ball {
    pub x: f64,
    pub y: f64,
    pub w: f64,
    pub h: f64,
}

impl Ball {
    fn new() -> Self {
        Self {
            x: 0.0,
            y: 0.0,
            w: 16.0,
            h: 16.0,
        }
    }

    fn update(&mut self) {
        self.x += 1.0;
        self.y += 1.0;
    }

    fn draw(&self, ctx: &web_sys::CanvasRenderingContext2d) {
        ctx.set_fill_style(&"red".into());
        ctx.begin_path();

        ctx.fill_rect(self.x, self.y, self.w, self.h);

        ctx.close_path();
    }
}

struct Game {
    ball: Ball,
    ellapsed_frames: i64,
}

impl Game {
    fn new() -> Self {
        Self {
            ball: Ball::new(),
            ellapsed_frames: 0,
        }
    }

    fn update(&mut self) {
        self.ellapsed_frames += 1;

        self.ball.update();
    }

    fn draw(&self, canvas: &web_sys::HtmlCanvasElement, context: &web_sys::CanvasRenderingContext2d) {
        // clear screen
        context.clear_rect(0.0, 0.0, canvas.width() as f64, canvas.height() as f64);

        self.ball.draw(context);
    }
}

fn window() -> web_sys::Window {
    web_sys::window().expect("no global `window` exists")
}

fn request_animation_frame(f: &Closure<dyn FnMut()>) {
    window()
        .request_animation_frame(f.as_ref().unchecked_ref())
        .expect("should register `requestAnimationFrame` OK");
}

fn document() -> web_sys::Document {
    window()
        .document()
        .expect("should have a document on window")
}

fn canvas() -> web_sys::HtmlCanvasElement {
    let document = document();
    let canvas = document.get_element_by_id("canvas").unwrap();

    canvas
        .dyn_into::<web_sys::HtmlCanvasElement>()
        .map_err(|_| ())
        .unwrap()
}

fn context(canvas: &web_sys::HtmlCanvasElement) -> web_sys::CanvasRenderingContext2d {
    canvas
        .get_context("2d")
        .unwrap()
        .unwrap()
        .dyn_into::<web_sys::CanvasRenderingContext2d>()
        .unwrap()
}

#[wasm_bindgen(start)]
pub fn run() -> Result<(), JsValue> {
    let f = Rc::new(RefCell::new(None));
    let g = f.clone();

    let mut game = Game::new();
    let canvas = canvas();
    let context = context(&canvas);

    *g.borrow_mut() = Some(Closure::wrap(Box::new(move || {
        game.update();
        game.draw(&canvas, &context);

        request_animation_frame(f.borrow().as_ref().unwrap());
    }) as Box<dyn FnMut()>));

    request_animation_frame(g.borrow().as_ref().unwrap());
    Ok(())
}