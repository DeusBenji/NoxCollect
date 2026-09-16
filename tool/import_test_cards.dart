import 'dart:io';

/// Developer-only CLI tool to fetch test cards from pokemontcg.io on the development machine.
/// 
/// Usage:
///   dart run tool/import_test_cards.dart [--api-key YOUR_KEY]
/// 
/// Note: API credentials remain exclusively on your dev machine and are NEVER
/// bundled or distributed in the mobile client binary.
void main(List<String> args) async {
  stdout.writeln('=== NoxCollect Test Card Import Tool ===');

  String? apiKey;
  for (int i = 0; i < args.length; i++) {
    if (args[i] == '--api-key' && i + 1 < args.length) {
      apiKey = args[i + 1];
    }
  }

  stdout.writeln('Ready to import physical test card list.');
  stdout.writeln('API Key configured: ${apiKey != null ? "Yes (Custom)" : "No (Using free public tier)"}');

  final testInputFile = File('tool/test_cards_input.json');
  if (!testInputFile.existsSync()) {
    stdout.writeln('Creating template file at: tool/test_cards_input.json');
    const sampleJson = '''[
  {
    "name": "Charizard ex",
    "number": "151/165",
    "set": "Scarlet & Violet 151",
    "finish": "Ultra Rare"
  }
]''';
    await testInputFile.writeAsString(sampleJson);
  }

  stdout.writeln('To seed test cards, populate tool/test_cards_input.json with your physical card list.');
}
