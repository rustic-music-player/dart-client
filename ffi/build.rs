use dart_bindgen::{config::*, Codegen};

fn main() {
    generate_c_header();
    generate_dart_binding();
}

fn generate_c_header() {
    let crate_dir = std::env::var("CARGO_MANIFEST_DIR").unwrap();
    let mut config = cbindgen::Config::default();
    config.language = cbindgen::Language::C;
    config.braces = cbindgen::Braces::SameLine;
    config.cpp_compat = true;
    config.style = cbindgen::Style::Both;
    cbindgen::Builder::new()
        .with_crate(crate_dir)
        .with_config(config)
        .generate()
        .expect("Unable to generate bindings")
        .write_to_file("bindings.h");
}

fn generate_dart_binding() {
    let config = DynamicLibraryConfig {
        ios: DynamicLibraryCreationMode::Executable.into(),
        android: DynamicLibraryCreationMode::open("librustic_dart.so").into(),
        ..Default::default()
    };
    let codegen = Codegen::builder()
        .with_src_header("bindings.h")
        .with_lib_name("librustic")
        .with_config(config)
        .build()
        .unwrap();
    let bindings = codegen.generate().unwrap();
    bindings
        .write_to_file("../lib/ffi.g.dart")
        .unwrap();
}
