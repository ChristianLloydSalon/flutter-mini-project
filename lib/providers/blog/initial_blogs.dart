import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mini_project/feature_blog/domain/model/blog.dart';
import 'dart:typed_data';

import 'package:uuid/uuid.dart';

final initialBlogsProvider = Provider<InitialBlogs>((ref) {
  return InitialBlogs();
});

class InitialBlogs {
  Future<List<Blog>> initialBlogs() async {
    const uuid = Uuid();
    final dateNow = DateTime.now();
    final formatter = DateFormat.yMMMd('en_US').format(dateNow);

    Uint8List _blogImage0 =
        (await rootBundle.load('assets/images/horizon-forbidden-west.jpg'))
            .buffer
            .asUint8List();
    Uint8List _blogImage1 =
        (await rootBundle.load('assets/images/dying-light-2.jpg'))
            .buffer
            .asUint8List();
    Uint8List _blogImage2 =
        (await rootBundle.load('assets/images/god-of-war-ragnarok.jpg'))
            .buffer
            .asUint8List();
    Uint8List _blogImage3 =
        (await rootBundle.load('assets/images/miles-morales.png'))
            .buffer
            .asUint8List();

    return [
      Blog(
        id: uuid.v1(),
        title: r'Horizon Forbidden West',
        subtitle: r'Guerilla Games',
        content: r'Horizon Forbidden West continues the story of Aloy half a year later after the events of the Zero Dawn, '
            r'a young huntress of the Nora tribe sent on a quest to a mysterious frontier spanning Utah to the Pacific coast '
            r'to find the source of a mysterious plague that kills all it infects. On her journey across the uncharted lands of '
            r'the Forbidden West, she encounters hostile regions filled with natural threats and ravaged by massive storms, '
            r'dangerous enemies and deadly machines, both new and old. As Aloy attempts to explore the wider and deeper parts of '
            r'the Forbidden West, she discovers a vast array of diverse environmental ecosystems, including lush valleys, dry deserts, '
            r'snowy mountains, tropical beaches and ruined cities, both above and below the water.',
        date: formatter,
        image: _blogImage0,
      ),
      Blog(
        id: uuid.v1(),
        title: 'Dying Light 2',
        subtitle: r'Techland',
        content: r"Over twenty years ago in Harran, we fought the virus—and lost. Now, we’re losing again. The City, "
        r"one of the last large human settlements, is torn by conflict. Civilization has fallen back into the Dark Ages. And yet, "
        r"we still have hope. You are a wanderer with the power to change the fate of The City. But your exceptional abilities come "
        r"at a price. Haunted by memories you cannot decipher, you set out to learn the truth… and find yourself in a combat zone. Hone "
        r"your skills, as to defeat your enemies and make allies, you’ll need both fists and wits. Unravel the dark secrets behind the "
        r"wielders of power, choose sides and decide your destiny. But wherever your actions take you, there's one thing you can never "
        r"forget—stay human.",
        date: formatter,
        image: _blogImage1,
      ),
      Blog(
        id: uuid.v1(),
        title: r'God of War Ragnarok',
        subtitle: r'Santa Monica Studios',
        content: r'Although exact details are unknown, the game will pick up approximately three years after the events of God of War '
        r'due to Fimbulwinter, which saw the beginning of Ragnarök with the death of Magni, Modi and Baldur, with both Freya and Thor '
        r'seeking revenge against Kratos and Atreus.',
        date: formatter,
        image: _blogImage2,
      ),
      Blog(
        id: uuid.v1(),
        title: r"Marvel's Spider-Man: Miles Morales",
        subtitle: r'Insomniac Games',
        content: r"The story picks up about a year after the events of The City That Never Sleeps. Miles Morales, having gained spider-like "
        r"powers himself at the end of Marvel's Spider-Man, looks to become the newest web-slinger of New York City under the guidance of his "
        r"mentor, Peter Parker.",
        date: formatter,
        image: _blogImage3,
      ),
    ];
  }
}
