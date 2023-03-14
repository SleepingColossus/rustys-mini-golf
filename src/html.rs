use wasm_bindgen::JsCast;

pub struct Html {
    pub window: web_sys::Window,
    pub document: web_sys::Document,
    pub canvas_game: web_sys::HtmlCanvasElement,
    pub context_game: web_sys::CanvasRenderingContext2d,
    pub canvas_bg: web_sys::HtmlCanvasElement,
    pub context_bg: web_sys::CanvasRenderingContext2d,
}

fn get_canvas_by_id(document: &web_sys::Document, canvas_id: &str) -> web_sys::HtmlCanvasElement {
    let canvas = document.get_element_by_id(canvas_id).unwrap();
    canvas
        .dyn_into::<web_sys::HtmlCanvasElement>()
        .map_err(|_| ())
        .unwrap()
}

fn get_context_for_canvas(canvas: &web_sys::HtmlCanvasElement) -> web_sys::CanvasRenderingContext2d {
    canvas
        .get_context("2d")
        .unwrap()
        .unwrap()
        .dyn_into::<web_sys::CanvasRenderingContext2d>()
        .unwrap()
}

impl Html {
    pub fn new() -> Self {
        let window = web_sys::window().expect("no global `window` exists");
        let document = window.document().expect("should have a document on window");
        let canvas_game = get_canvas_by_id(&document, "canvas-game");
        let context_game = get_context_for_canvas(&canvas_game);
        let canvas_bg = get_canvas_by_id(&document, "canvas-background");
        let context_bg = get_context_for_canvas(&canvas_bg);

        Self {
            window,
            document,
            canvas_game,
            context_game,
            canvas_bg,
            context_bg,
        }
    }

    // TODO figure out how to use this method instead of one in main
    // pub fn request_animation_frame(&self, f: &Closure<dyn FnMut()>) {
    //     &self.window
    //         .request_animation_frame(f.as_ref().unchecked_ref())
    //         .expect("should register `requestAnimationFrame` OK");
    // }

    pub fn get_image_by_id(&self, image_id: &str) -> web_sys::HtmlImageElement {
        self.document
            .get_element_by_id(image_id)
            .unwrap()
            .dyn_into::<web_sys::HtmlImageElement>()
            .map_err(|_| ())
            .unwrap()
    }
}
