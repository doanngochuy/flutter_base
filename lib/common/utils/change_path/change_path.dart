import 'dart:html' as html;

void handleUrlNotReloadWeb({
  required String name,
  required String path,
}) {
  html.window.history.pushState(
    null,
    name,
    path,
  );
}
