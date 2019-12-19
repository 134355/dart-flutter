import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'dart:io';

class ImagePath {
  final String pathName;
  final String className;

  const ImagePath(this.pathName, this.className);
}

class ImagePathGenerator extends GeneratorForAnnotation<ImagePath> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {

    final explanation = '''
      // **************************************************************************
      // 注意：生成的代码，请勿手动修改
      // 如果存在新文件需要更新，建议先执行清除命令：
      // flutter packages pub run build_runner clean
      // 然后执行下列命令重新生成相应文件：
      // flutter packages pub run build_runner build --delete-conflicting-outputs
      // **************************************************************************''';

    String _codeContent = '';
    String pathName= annotation.read('pathName').stringValue;
    String className = annotation.read('className').stringValue;

    if (!pathName.endsWith('/')) {
      pathName = '$pathName/';
    }

    void _handleFile(String path) {
      var directory = Directory(path);
      if (directory == null) {
        throw '$path 不是目录';
      }

      for (var file in directory.listSync()) {
        var type = file.statSync().type;

        if (type == FileSystemEntityType.directory) {
          _handleFile('${file.path}/');
        } else if (type == FileSystemEntityType.file) {
          var filePath = file.path;
          var keyName = filePath.trim().toUpperCase();

          if (!keyName.endsWith('.PNG') &&
              !keyName.endsWith('.JPEG') &&
              !keyName.endsWith('.SVG') &&
              !keyName.endsWith('.JPG')) continue;
          var key = keyName
              .replaceAll(RegExp(path.toUpperCase()), '')
              .replaceAll(RegExp('.PNG'), '')
              .replaceAll(RegExp('.JPEG'), '')
              .replaceAll(RegExp('.SVG'), '')
              .replaceAll(RegExp('.JPG'), '');

          _codeContent = '''
            $_codeContent
            static const String $key = '$filePath';''';
        }
      }
    }

    _handleFile(pathName);
    
    return '''
      $explanation
      class $className{
        $className._();
        $_codeContent
      }''';

  }
}

Builder imagePathBuilder(BuilderOptions options) => LibraryBuilder(ImagePathGenerator());
