class SvgImageRepo {
  static const List<String> svgPaths = [
    'hero_women.svg',
    'hero_doc1.svg',
    'hero_doc2.svg',
    'hero_doc3.svg',
  ];

  static int getIndex(String path) {
    return svgPaths.indexOf(path);
  }

  static String getPathFromIndex(int index) {
    return svgPaths[index];
  }
}
