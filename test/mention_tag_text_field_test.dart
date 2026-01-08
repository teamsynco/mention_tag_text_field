import 'package:flutter_test/flutter_test.dart';
import 'package:mention_tag_text_field/src/mention_tag_data.dart';
import 'package:mention_tag_text_field/src/mention_tag_decoration.dart';
import 'package:mention_tag_text_field/src/mention_tag_text_editing_controller.dart';
import 'package:flutter/services.dart';

void main() {
  group('MentionTagTextEditingController.insertMentionDirectly', () {
    test('inserts correctly at the beginning of the text', () {
      final controller = MentionTagTextEditingController();
      controller.mentionTagDecoration = const MentionTagDecoration(); // mentionBreak: ' '

      controller.text = 'hello';
      controller.selection = const TextSelection.collapsed(offset: 0);

      controller.insertMentionDirectly(
        const MentionTagElement(mentionSymbol: '@', mention: '@rowan'),
      );

      expect(controller.text, '‡ hello');
      expect(controller.selection.baseOffset, '‡ '.length);
    });

    test('adds break after when current text is empty', () {
      final controller = MentionTagTextEditingController();
      controller.mentionTagDecoration = const MentionTagDecoration(); // mentionBreak: ' '

      controller.text = '';
      controller.selection = const TextSelection.collapsed(offset: 0);

      controller.insertMentionDirectly(
        const MentionTagElement(mentionSymbol: '@', mention: '@rowan'),
      );

      expect(controller.text, '‡ ');
      expect(controller.selection.baseOffset, 2);
    });

    test('inserts correctly at the end of the text', () {
      final controller = MentionTagTextEditingController();
      controller.mentionTagDecoration = const MentionTagDecoration(); // mentionBreak: ' '

      controller.text = 'hello';
      controller.selection = const TextSelection.collapsed(offset: 5);

      controller.insertMentionDirectly(
        const MentionTagElement(mentionSymbol: '@', mention: '@rowan'),
      );

      expect(controller.text, 'hello ‡ ');
      expect(controller.selection.baseOffset, 'hello ‡ '.length);
    });

    test('adds break before and after when adjacent chars are not whitespace', () {
      final controller = MentionTagTextEditingController();
      controller.mentionTagDecoration = const MentionTagDecoration(); // mentionBreak: ' '

      controller.text = 'helloWorld';
      controller.selection = const TextSelection.collapsed(offset: 5);

      controller.insertMentionDirectly(
        const MentionTagElement(mentionSymbol: '@', mention: '@rowan'),
      );

      expect(controller.text, 'hello ‡ World');
      expect(controller.selection.baseOffset, 'hello ‡ '.length);
    });

    test('does not add duplicate spaces when already present', () {
      final controller = MentionTagTextEditingController();
      controller.mentionTagDecoration = const MentionTagDecoration(); // mentionBreak: ' '

      controller.text = 'hello world';
      controller.selection = const TextSelection.collapsed(offset: 6);

      controller.insertMentionDirectly(
        const MentionTagElement(mentionSymbol: '@', mention: '@rowan'),
      );

      expect(controller.text, 'hello ‡ world');
      expect(controller.selection.baseOffset, 'hello ‡ '.length);
    });
  });
}
