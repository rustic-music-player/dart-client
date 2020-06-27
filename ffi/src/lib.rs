mod models;
#[macro_use]
mod helpers;

use allo_isolate::Isolate;
use ffi_helpers::null_pointer_check;
use lazy_static::lazy_static;
use std::{ffi::CStr, io, os::raw};
use tokio::runtime::{Builder, Runtime};

use rustic_api::client::*;
use rustic_native_http_client::RusticNativeHttpClient;

use crate::models::*;

lazy_static! {
    static ref RUNTIME: io::Result<Runtime> = Builder::new()
        .threaded_scheduler()
        .enable_all()
        .core_threads(4)
        .thread_name("rustic-client")
        .build();
}

#[no_mangle]
pub unsafe extern "C" fn last_error_length() -> i32 {
    ffi_helpers::error_handling::last_error_length()
}

#[no_mangle]
pub unsafe extern "C" fn error_message_utf8(buf: *mut raw::c_char, length: i32) -> i32 {
    ffi_helpers::error_handling::error_message_utf8(buf, length)
}

#[no_mangle]
pub extern "C" fn get_album(port: i64, base_url: *const raw::c_char, cursor: *const raw::c_char) -> i32 {
    let rt = runtime!();
    let cursor = cstr!(cursor);
    let client = RusticNativeHttpClient::new(cstr!(base_url));
    rt.spawn(async move {
        let result = client.get_album(cursor).await;
        let isolate = Isolate::new(port);
        isolate.post(result.map(|r| r.map(DartAlbumModel)));
    });
    0
}
