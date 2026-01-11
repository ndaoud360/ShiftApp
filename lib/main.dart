import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ShiftingRealityApp());
}

class ShiftingRealityApp extends StatelessWidget {
  const ShiftingRealityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shifting Reality',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A1A1A),
          brightness: Brightness.light,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

// ==================== DATA MODELS ====================

class ShiftingMethod {
  final String id;
  final String name;
  final String description;
  final String category;
  final String imageUrl;
  final bool isCustom;
  final double rating;
  final int reviews;
  List<Attempt> attempts;

  ShiftingMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    this.isCustom = false,
    this.rating = 4.8,
    this.reviews = 120,
    List<Attempt>? attempts,
  }) : attempts = attempts ?? [];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'category': category,
        'imageUrl': imageUrl,
        'isCustom': isCustom,
        'rating': rating,
        'reviews': reviews,
        'attempts': attempts.map((a) => a.toJson()).toList(),
      };

  factory ShiftingMethod.fromJson(Map<String, dynamic> json) => ShiftingMethod(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        category: json['category'] ?? 'Popular',
        imageUrl: json['imageUrl'],
        isCustom: json['isCustom'] ?? false,
        rating: (json['rating'] ?? 4.8).toDouble(),
        reviews: json['reviews'] ?? 120,
        attempts: (json['attempts'] as List?)
                ?.map((a) => Attempt.fromJson(a))
                .toList() ??
            [],
      );
}

class Attempt {
  final String id;
  final DateTime date;
  String notes;

  Attempt({
    required this.id,
    required this.date,
    required this.notes,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'notes': notes,
      };

  factory Attempt.fromJson(Map<String, dynamic> json) => Attempt(
        id: json['id'],
        date: DateTime.parse(json['date']),
        notes: json['notes'] ?? '',
      );
}

class Script {
  final String id;
  String title;
  String content;
  final DateTime createdAt;
  DateTime updatedAt;

  Script({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory Script.fromJson(Map<String, dynamic> json) => Script(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );
}

// ==================== DEFAULT METHODS DATA ====================

List<ShiftingMethod> getDefaultMethods() {
  return [
    ShiftingMethod(
      id: 'raven',
      name: 'Raven Method',
      category: 'Popular',
      rating: 4.9,
      reviews: 2847,
      description:
          '''The Raven Method is one of the most popular shifting methods, perfect for beginners.

How to do it:

1. Lie down in a comfortable position, preferably in a starfish pose (arms and legs spread out, not touching).

2. Close your eyes and begin to relax your entire body, starting from your toes and working up to your head.

3. Start counting slowly from 1 to 100. Between each number, recite an affirmation such as "I am shifting" or "I am in my desired reality."

4. As you count, visualize your desired reality. Imagine yourself there, engaging all your senses - what do you see, hear, smell, feel?

5. You may begin to feel symptoms like tingling, floating, or seeing bright lights. These are signs you're close to shifting.

6. Continue until you feel yourself fully in your desired reality or fall asleep with the intention to wake up there.

Tips:
• Don't move during the process
• Stay calm if you feel symptoms
• Trust the process and don't force it
• Best done when tired or before sleep''',
      imageUrl:
          'https://images.unsplash.com/photo-1507400492013-162706c8c05e?w=800',
    ),
    ShiftingMethod(
      id: 'julia',
      name: 'Julia Method',
      category: 'Popular',
      rating: 4.8,
      reviews: 1923,
      description:
          '''The Julia Method focuses on "I am" affirmations and is excellent for those who respond well to verbal repetition.

How to do it:

1. Lie down comfortably and put on theta waves or binaural beats (optional but helpful).

2. Begin by saying "I am" repeatedly in your mind. This helps quiet your thoughts and center your consciousness.

3. After a few minutes, start adding affirmations: "I am shifting," "I am in my desired reality," "I am [your DR self's name]."

4. Visualize your desired reality while continuing the affirmations. Feel yourself becoming your DR self.

5. When you feel ready, begin counting from 1 to 100, interspersing affirmations between numbers.

6. You may feel symptoms like vibrations, floating, or hear sounds from your DR. Keep going.

7. When you feel fully shifted, open your eyes in your desired reality.

Tips:
• Focus on the feeling of "I am" - pure existence
• Don't rush the affirmations
• Really feel each statement as true
• This method works well combined with the Raven Method''',
      imageUrl:
          'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=800',
    ),
    ShiftingMethod(
      id: 'pillow',
      name: 'Pillow Method',
      category: 'Beginner',
      rating: 4.7,
      reviews: 3156,
      description:
          '''The Pillow Method is one of the simplest methods, great for beginners or those who have trouble with visualization.

How to do it:

1. Write down affirmations and details about your desired reality on a piece of paper. Include things like "I have shifted to my DR" and specific details about where you want to go.

2. You can also write your script or key points about your DR self.

3. Place the paper under your pillow before going to sleep.

4. As you fall asleep, repeat affirmations in your mind and visualize your desired reality.

5. Set a strong intention to wake up in your desired reality.

6. Fall asleep naturally while maintaining your intention.

Tips:
• Be specific in what you write
• Truly believe what you've written
• Combine with other methods for stronger results
• Keep the same paper for multiple attempts if you wish
• Some people like to hold the paper while falling asleep''',
      imageUrl:
          'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?w=800',
    ),
    ShiftingMethod(
      id: 'alice',
      name: 'Alice in Wonderland',
      category: 'Visualization',
      rating: 4.8,
      reviews: 1547,
      description:
          '''Inspired by Alice in Wonderland, this method uses the imagery of following someone down a rabbit hole.

How to do it:

1. Lie down comfortably on your back with your eyes closed.

2. Visualize yourself sitting against a tree in a peaceful forest or garden.

3. Imagine someone from your desired reality running past you - someone you want to see in your DR.

4. Get up and chase after them. They lead you to a rabbit hole.

5. Jump into the rabbit hole after them. Feel yourself falling, falling, falling...

6. As you fall, you might see memories from your CR floating past, or glimpses of your DR.

7. Eventually, you land softly in your desired reality. The person you chased helps you up.

8. Open your eyes in your DR.

Tips:
• Really engage with the visualization
• Feel the falling sensation
• Choose someone meaningful from your DR to follow
• Let the falling last as long as it needs to
• Don't force the landing''',
      imageUrl:
          'https://images.unsplash.com/photo-1440581572325-0bea30075d9d?w=800',
    ),
    ShiftingMethod(
      id: 'sunni',
      name: 'Sunni Method',
      category: 'Visualization',
      rating: 4.6,
      reviews: 1289,
      description:
          '''The Sunni Method is a visualization-heavy method where you imagine waking up in your desired reality.

How to do it:

1. Lie down in a comfortable position and close your eyes.

2. Instead of visualizing actions or scenarios, focus on visualizing yourself waking up in your desired reality.

3. Imagine the moment of opening your eyes in your DR. What's the first thing you see? Your DR bedroom ceiling? A person? A window?

4. Engage all your senses - what do you hear? Birds? Music? Someone calling your name?

5. Feel the bed or surface you're lying on in your DR. Feel the sheets, the temperature.

6. Keep this visualization going, making it more and more vivid and real.

7. You may feel yourself actually there. When it feels completely real, open your eyes.

Tips:
• Focus on the FEELING of being there, not just the visuals
• Make the visualization as detailed as possible
• Don't just observe - BE there
• This method works well when you're already drowsy
• Can be combined with affirmations''',
      imageUrl:
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
    ),
    ShiftingMethod(
      id: 'intent',
      name: 'Intent Method',
      category: 'Advanced',
      rating: 4.5,
      reviews: 987,
      description:
          '''The Intent Method is the simplest method - it relies purely on the power of intention without any visualization or counting.

How to do it:

1. This method is best done when you're already very tired and about to fall asleep.

2. As you're drifting off, simply set a firm intention to shift. Tell yourself "I will shift tonight" or "I will wake up in my desired reality."

3. Believe it completely. Know it to be true.

4. Fall asleep holding onto this intention.

5. Wake up in your desired reality.

Why it works:

The Intent Method works because shifting is fundamentally about consciousness and belief. When you set a genuine, strong intention without doubt, you align your subconscious with your goal.

Tips:
• This works best for experienced shifters who have strong belief
• Don't overthink it - the simplicity is the point
• Make sure your intention is clear and definite
• Combine with scripting earlier in the day
• Trust yourself completely''',
      imageUrl:
          'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?w=800',
    ),
    ShiftingMethod(
      id: 'elevator',
      name: 'Elevator Method',
      category: 'Visualization',
      rating: 4.7,
      reviews: 1456,
      description:
          '''The Elevator Method uses the visualization of an elevator taking you up to your desired reality.

How to do it:

1. Lie down comfortably and close your eyes. Relax your body completely.

2. Visualize yourself standing in front of an elevator. Notice the details - the doors, the call button, the floor you're on.

3. Press the button and wait for the elevator. When it arrives, step inside.

4. Notice the interior of the elevator. There's a panel with many floor buttons. Your desired reality is at the top floor.

5. Press the top floor button. Feel the elevator begin to rise.

6. With each floor you pass, feel your energy rising. You may see the floor numbers lighting up or feel the gentle movement.

7. You might encounter someone from your DR in the elevator with you.

8. When you reach the top floor, the doors open to reveal your desired reality.

9. Step out into your DR and open your eyes.

Tips:
• Make the elevator as detailed as you like
• Feel the physical sensation of rising
• Use this time to recite affirmations
• The elevator can be any style you want''',
      imageUrl:
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800',
    ),
    ShiftingMethod(
      id: 'train',
      name: 'Train Method',
      category: 'Visualization',
      rating: 4.8,
      reviews: 1678,
      description:
          '''The Train Method visualizes a train journey to your desired reality, perfect for those who enjoy travel imagery.

How to do it:

1. Get comfortable, close your eyes, and begin to relax.

2. Visualize yourself at a train station. Notice the platform, the tracks, other passengers.

3. A train arrives - this is YOUR train, the one going to your desired reality. It might look special or have your DR's name on it.

4. Board the train and find a seat. Get comfortable.

5. Look out the window as the train begins to move. You might see your current reality fading away, or glimpses of the journey between realities.

6. Someone from your DR might be sitting across from you or come to find you on the train.

7. Feel the gentle motion of the train. Hear the sounds. This journey is taking you to your DR.

8. When the train stops and the doors open, you've arrived at your destination - your desired reality.

9. Step off the train and into your new life.

Tips:
• The journey can be as long or short as you need
• Engage all senses - the train sounds, smells, feelings
• You can fall asleep on the train and wake up in your DR
• Make the destination station in your DR somewhere meaningful''',
      imageUrl:
          'https://images.unsplash.com/photo-1474487548417-781cb71495f3?w=800',
    ),
    ShiftingMethod(
      id: 'rope',
      name: 'Rope Method',
      category: 'Advanced',
      rating: 4.6,
      reviews: 1123,
      description:
          '''The Rope Method involves visualizing climbing a rope from your current reality to your desired reality.

How to do it:

1. Lie down in a comfortable position. A meditation pose works well.

2. Close your eyes and relax completely. Let your body become heavy.

3. Visualize a rope hanging above you, descending from your desired reality.

4. Without moving your physical body, visualize your consciousness/soul/astral body reaching up and grabbing the rope.

5. Begin to climb. Feel your hands gripping the rope, pulling yourself up. Feel your arms working.

6. As you climb, you leave your current reality further behind. You're ascending toward your DR.

7. You may feel physical sensations - tingling, vibrations, floating. Keep climbing.

8. Eventually, you reach the top. Pull yourself up and into your desired reality.

9. Open your eyes in your DR.

Tips:
• Really feel the physical sensation of climbing
• Don't rush - take your time on the rope
• The rope can look however you want
• Some people add affirmations with each pull upward
• This method is great for those who like kinesthetic visualization''',
      imageUrl:
          'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800',
    ),
    ShiftingMethod(
      id: 'heartbeat',
      name: 'Heartbeat Method',
      category: 'Audio',
      rating: 4.9,
      reviews: 2134,
      description:
          '''The Heartbeat Method uses audio of heartbeats to help you shift, simulating connection with someone from your DR.

How to do it:

1. Find a heartbeat audio track - there are many on YouTube specifically for shifting.

2. Lie down comfortably with headphones in, playing the heartbeat audio.

3. Close your eyes and imagine the heartbeat belongs to someone from your desired reality - someone you're close to there.

4. Visualize yourself lying with your head on their chest, listening to their heartbeat.

5. Imagine them talking to you, welcoming you to your DR. What do they say? How does their voice sound?

6. Feel their presence, their warmth. You are with them in your DR.

7. Let this feeling of connection and presence guide you into your DR.

8. When you feel fully there, open your eyes.

Tips:
• Choose someone meaningful from your DR
• Use comfortable headphones you can sleep in
• The heartbeat helps induce a meditative state
• Focus on emotional connection, not just physical
• Great for DRs where you have close relationships''',
      imageUrl:
          'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=800',
    ),
    ShiftingMethod(
      id: 'mirror',
      name: 'Mirror Method',
      category: 'Visualization',
      rating: 4.7,
      reviews: 1345,
      description:
          '''The Mirror Method uses the symbolism of mirrors as portals between realities.

How to do it:

1. Lie down and get comfortable. Close your eyes and relax.

2. Visualize yourself in a dark room with a single mirror in front of you.

3. Walk toward the mirror. As you get closer, you see your reflection - but it's your DR self looking back at you.

4. Study your DR self. Notice how they look, what they're wearing, their expression.

5. Reach out and touch the mirror. Feel it ripple like water under your fingers.

6. Step through the mirror. Feel yourself passing through, merging with your DR self.

7. You are now in your DR, in your DR body. Turn around - the mirror shows your CR self fading away.

8. Walk away from the mirror and into your desired reality.

9. Open your eyes.

Tips:
• The mirror can be any style - ornate, simple, magical
• Focus on becoming your DR self, not just visiting
• Some people like to have someone from their DR waiting on the other side
• The merging sensation is key - really feel it
• Great for DRs where you look different''',
      imageUrl:
          'https://images.unsplash.com/photo-1509909756405-be0199881695?w=800',
    ),
    ShiftingMethod(
      id: 'estelle',
      name: 'Estelle Method',
      category: 'Audio',
      rating: 4.8,
      reviews: 1567,
      description:
          '''The Estelle Method involves dancing with someone from your DR, using movement and emotional connection.

How to do it:

1. Put on a slow song that reminds you of your DR or a song that would be meaningful there.

2. Lie down comfortably and close your eyes.

3. Visualize yourself in a ballroom or meaningful location in your DR.

4. Someone from your DR approaches and asks you to dance. This should be someone important to you in your DR.

5. Begin to dance with them. Feel their hands, their presence. Move to the music.

6. As you dance, they whisper things to you about your DR, your life there, how happy they are you've come.

7. Feel yourself fully present in this moment in your DR.

8. The song ends. They lead you away from the dance floor and into your DR life.

9. Open your eyes.

Tips:
• Choose a song with emotional significance
• The dancing helps create physical/kinesthetic visualization
• Focus on the emotional connection
• Let the dance be intimate and meaningful
• You can actually physically feel yourself swaying slightly''',
      imageUrl:
          'https://images.unsplash.com/photo-1504609813442-a8924e83f76e?w=800',
    ),
    ShiftingMethod(
      id: 'staircase',
      name: 'Staircase Method',
      category: 'Visualization',
      rating: 4.6,
      reviews: 1234,
      description:
          '''The Staircase Method visualizes climbing or descending stairs to reach your desired reality.

How to do it:

1. Get comfortable and close your eyes. Relax your whole body.

2. Visualize yourself at the bottom of a staircase. This staircase leads to your DR.

3. The staircase can look however you want - grand marble stairs, a cozy wooden staircase, a spiral staircase, etc.

4. Begin climbing. With each step, feel yourself getting closer to your DR.

5. Count the steps if you like, or recite affirmations with each one: "I am one step closer to my DR."

6. You may see or feel things changing as you climb - the light, the temperature, the sounds.

7. At the top of the staircase is a door. When you're ready, open it.

8. Step through into your desired reality.

9. Open your eyes.

Tips:
• The number of stairs can vary - usually between 10 and 100
• Some people prefer descending stairs instead
• Make each step deliberate and meaningful
• You can have someone waiting at the top
• The door can be decorated with DR symbols''',
      imageUrl:
          'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800',
    ),
    ShiftingMethod(
      id: 'cloud',
      name: 'Cloud Method',
      category: 'Beginner',
      rating: 4.7,
      reviews: 1789,
      description:
          '''The Cloud Method is a gentle, dreamy method where a cloud carries you to your DR.

How to do it:

1. Lie down on your back in a comfortable position. Close your eyes.

2. Visualize yourself lying on the softest, most comfortable cloud imaginable.

3. Feel the cloud beneath you - it's warm, supportive, and peaceful.

4. The cloud begins to rise, lifting you gently into the sky.

5. You float through the air, leaving your current reality behind. You might see it getting smaller below you.

6. The cloud carries you through beautiful skies - maybe you see stars, colors, or other clouds.

7. Someone from your DR might join you on the cloud for the journey.

8. Eventually, the cloud begins to descend, bringing you down into your desired reality.

9. The cloud lands softly. You step off into your DR.

10. Open your eyes.

Tips:
• Focus on the sensation of floating
• Make the cloud as comfortable and magical as you want
• The journey can include beautiful sights
• Very relaxing method - good for anxious shifters
• Great for those who have flying dreams''',
      imageUrl:
          'https://images.unsplash.com/photo-1534088568595-a066f410bcda?w=800',
    ),
    ShiftingMethod(
      id: 'wbtb',
      name: 'WBTB Method',
      category: 'Advanced',
      rating: 4.9,
      reviews: 2456,
      description:
          '''WBTB (Wake Back To Bed) is a technique borrowed from lucid dreaming that's highly effective for shifting.

How to do it:

1. Go to sleep at your normal time with the intention to wake up after 5-6 hours.

2. Set an alarm for 5-6 hours after you fall asleep.

3. When the alarm goes off, wake up but stay in a drowsy state. Don't fully wake up or turn on bright lights.

4. Stay awake for 15-30 minutes. During this time, read your script, recite affirmations, or visualize your DR.

5. Go back to sleep using any shifting method you prefer - Raven, Julia, Intent, etc.

6. The combination of being in a drowsy, hypnagogic state plus your focused intention makes shifting much easier.

7. Wake up in your desired reality.

Tips:
• Don't stay awake too long - you want to stay drowsy
• Keep lights dim and don't look at your phone
• Have your script ready to read during the wake period
• This method has high success rates
• Combines well with any other method
• The drowsy state is perfect for shifting''',
      imageUrl:
          'https://images.unsplash.com/photo-1495197359483-d092478c5e4b?w=800',
    ),
    ShiftingMethod(
      id: 'lucid',
      name: 'Lucid Dream Method',
      category: 'Advanced',
      rating: 4.8,
      reviews: 1987,
      description:
          '''This method involves first achieving a lucid dream, then using it as a portal to your DR.

How to do it:

1. First, achieve a lucid dream using any lucid dreaming technique (reality checks, WBTB, WILD, etc.).

2. Once you're lucid in a dream, stabilize the dream by touching surfaces, spinning, or stating "clarity now."

3. Find or create a portal to your DR. This could be a door, a mirror, a hole in the ground, or anything you want.

4. Alternatively, just state clearly: "I am now going to my desired reality" or "When I walk through this door, I'll be in my DR."

5. Go through the portal with full confidence and intention.

6. You'll arrive in your desired reality.

Tips:
• Practice lucid dreaming first if you're new to it
• The portal can be anything - get creative
• State your intention clearly in the dream
• Don't just explore the dream - focus on shifting
• Very effective for experienced lucid dreamers
• The dream state is already a shifted state of consciousness''',
      imageUrl:
          'https://images.unsplash.com/photo-1451186859696-371d9477be93?w=800',
    ),
    ShiftingMethod(
      id: 'void',
      name: 'Void State Method',
      category: 'Advanced',
      rating: 4.7,
      reviews: 1654,
      description:
          '''The Void State Method involves entering the void - a state of pure consciousness - before shifting.

How to do it:

1. Lie down in complete darkness and silence if possible. Get very comfortable.

2. Close your eyes and relax completely. Let all thoughts fade away.

3. Focus on nothing. You are pure consciousness - no body, no thoughts, no reality.

4. You may feel like you're floating in an infinite dark space. This is the void.

5. In the void, you have complete power. You can create and go anywhere.

6. From the void, intend to go to your DR. State: "I am going to my desired reality now."

7. Feel yourself shifting from the void to your DR.

8. Your DR will materialize around you. Open your eyes when it feels solid.

Tips:
• The void state takes practice to achieve
• Don't fight thoughts - let them pass through
• The void feels peaceful, not scary
• You have complete control in the void
• This is considered an advanced method
• Once you master the void, you can shift anywhere''',
      imageUrl:
          'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=800',
    ),
    ShiftingMethod(
      id: 'eleven',
      name: 'Eleven Method',
      category: 'Audio',
      rating: 4.8,
      reviews: 2234,
      description:
          '''Inspired by Eleven from Stranger Things, this method uses a sensory deprivation approach.

How to do it:

1. Lie down and put on a sleep mask or blindfold to block all light.

2. Put on white noise or static sounds through headphones (like Eleven's deprivation tank).

3. Lie still and let yourself float in the darkness and sound.

4. Visualize your DR. But more importantly, FEEL for your DR, like you're reaching out psychically.

5. You are powerful. You can find any reality. Reach out with your mind for your DR.

6. You'll begin to sense it, then feel it, then see it forming around you.

7. Your DR becomes solid. You're there.

8. Open your eyes.

Tips:
• The sensory deprivation helps you disconnect from your CR
• White noise/static is key to this method
• Imagine you have psychic powers like Eleven
• Reach out with your mind, not just visualization
• The power is within you
• Great for Stranger Things DRs obviously!''',
      imageUrl:
          'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?w=800',
    ),
    ShiftingMethod(
      id: 'hug',
      name: 'Hug Method',
      category: 'Beginner',
      rating: 4.9,
      reviews: 2567,
      description:
          '''The Hug Method focuses on emotional connection through visualizing a hug with someone from your DR.

How to do it:

1. Lie down and get comfortable. Close your eyes and relax.

2. Think of someone from your DR that you have a strong emotional connection with.

3. Visualize them appearing in front of you, happy to see you.

4. They open their arms and you embrace them. Feel the hug - their warmth, their presence, their arms around you.

5. They whisper welcome to you, tell you they've been waiting for you.

6. Feel the emotions - love, belonging, home. Let yourself feel safe and wanted.

7. When you pull back from the hug, you're in your DR together.

8. Open your eyes.

Tips:
• Choose someone you genuinely love or care about
• Really feel the physical sensation of the hug
• Emotions are the key to this method
• The feeling of coming home is powerful
• Great for DRs where relationships are important
• Can be very emotional - that's good''',
      imageUrl:
          'https://images.unsplash.com/photo-1516589178581-6cd7833ae3b2?w=800',
    ),
    ShiftingMethod(
      id: 'piano',
      name: 'Piano Method',
      category: 'Audio',
      rating: 4.6,
      reviews: 1123,
      description:
          '''The Piano Method involves playing piano with someone from your DR, using music as a bridge between realities.

How to do it:

1. Put on soft piano music if you like, then lie down and close your eyes.

2. Visualize yourself sitting at a piano in a beautiful room in your DR.

3. Someone from your DR sits beside you at the piano bench.

4. You begin to play together. Even if you can't play piano in your CR, you can in this visualization.

5. Feel the keys under your fingers, hear the music you create together.

6. This person talks to you as you play - about your life in your DR, about how they've missed you, about what you'll do together.

7. The music creates a connection between you and your DR. Feel yourself becoming more present there.

8. When the song ends, you're fully in your DR.

9. Open your eyes.

Tips:
• You don't need to know how to play piano in real life
• The song can be meaningful to your DR
• Focus on the connection with the person beside you
• Playing music together creates a powerful bond
• Great for musical DRs or DRs with a musician character''',
      imageUrl:
          'https://images.unsplash.com/photo-1520523839897-bd0b52f945a0?w=800',
    ),
    ShiftingMethod(
      id: 'falling',
      name: 'Falling Method',
      category: 'Visualization',
      rating: 4.5,
      reviews: 987,
      description:
          '''The Falling Method uses the sensation of falling to transition into your desired reality.

How to do it:

1. Lie down comfortably and close your eyes. Relax completely.

2. Visualize yourself standing on a high place - a cliff, a building, a cloud.

3. Below you, you can see your desired reality waiting.

4. Take a deep breath and let yourself fall.

5. Feel the rushing sensation of falling - the wind, the weightlessness, the exhilaration.

6. As you fall, you pass through layers between realities. You might see colors, lights, or visions.

7. You're not afraid - you know you're falling toward where you belong.

8. You land softly and safely in your desired reality.

9. Open your eyes.

Tips:
• The falling sensation is key - really feel it
• Don't fear the fall - embrace it
• The landing is always soft and safe
• Great for those who have falling dreams
• Can combine with affirmations during the fall
• Some people feel actual physical falling sensation''',
      imageUrl:
          'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?w=800',
    ),
    ShiftingMethod(
      id: 'blanket',
      name: 'Blanket Method',
      category: 'Beginner',
      rating: 4.8,
      reviews: 1876,
      description:
          '''The Blanket Method uses the comfort and security of a blanket to help you shift.

How to do it:

1. Wrap yourself in a comfortable blanket - this is your shifting blanket.

2. Lie down and close your eyes, cocooned in your blanket.

3. Imagine the blanket is magical - it has the power to transport you to your DR.

4. Feel the blanket begin to warm, to glow, to carry you.

5. Visualize someone from your DR also wrapping you in a blanket - you're being tucked in, in your DR.

6. The blanket from your CR and the blanket in your DR merge - they're the same blanket.

7. Feel yourself fully in your DR, safe and warm in your bed there.

8. Fall asleep in this visualization and wake up in your DR.

Tips:
• Use the same blanket each time for power
• Physical comfort really helps with this method
• The warmth and security aid relaxation
• Great for people who shift best while cozy
• The merging of blankets symbolizes merging of realities''',
      imageUrl:
          'https://images.unsplash.com/photo-1455659817273-f96807779a8a?w=800',
    ),
    ShiftingMethod(
      id: 'doubles',
      name: 'Doubles Method',
      category: 'Advanced',
      rating: 4.7,
      reviews: 1345,
      description:
          '''The Doubles Method involves meeting and merging with your DR self.

How to do it:

1. Lie down comfortably and close your eyes.

2. Visualize yourself in a neutral space - perhaps a white room or a void.

3. Your DR self appears in front of you. They look like you but as you are in your DR.

4. Study them. How do they stand? What are they wearing? What's different?

5. Walk toward each other until you're face to face.

6. Reach out and touch hands. You begin to merge.

7. Feel yourself stepping INTO your DR self. You become one.

8. You now have their memories, their body, their reality.

9. Open your eyes as your DR self, in your DR.

Tips:
• The merging is the key moment
• Feel yourself literally becoming them
• Accept their memories as your own
• Great if your DR self is different from CR you
• The touch is the trigger for merging
• You ARE them, they ARE you''',
      imageUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800',
    ),
    ShiftingMethod(
      id: 'ferris',
      name: 'Ferris Wheel Method',
      category: 'Visualization',
      rating: 4.6,
      reviews: 1098,
      description:
          '''The Ferris Wheel Method uses the imagery of a ferris wheel rising up to your DR.

How to do it:

1. Lie down and close your eyes. Relax completely.

2. Visualize yourself at a carnival or amusement park at night, lights twinkling.

3. You're about to get on a ferris wheel. Someone from your DR is with you.

4. You both get into a car/gondola together. The ferris wheel starts moving.

5. As you rise, you see your current reality below, getting smaller.

6. At the very top, you can see your DR in the distance - another reality.

7. The ferris wheel continues - as you go down the other side, you're descending into your DR.

8. The ride ends and you step off - in your desired reality.

9. Open your eyes.

Tips:
• The carnival atmosphere is fun and positive
• The person with you grounds you to your DR
• The top of the ferris wheel is the transition point
• Feel the movement of the ride
• Great for people who like carnival/fair imagery
• The descent into DR can be exciting''',
      imageUrl:
          'https://images.unsplash.com/photo-1570394651828-d8c7b4b76f3a?w=800',
    ),
    ShiftingMethod(
      id: 'eye',
      name: 'Eye Method',
      category: 'Beginner',
      rating: 4.5,
      reviews: 1234,
      description:
          '''The Eye Method focuses on the sensation of opening your eyes in your desired reality.

How to do it:

1. Lie down comfortably and close your eyes.

2. Take deep breaths and fully relax your body.

3. Begin reciting affirmations: "My eyes will open in my desired reality."

4. Visualize your DR eyes. Feel them as if they're your own - because they are.

5. Feel your DR eyelids. They're heavy but ready to open.

6. Continue affirming: "When I open my eyes, I will be in my DR."

7. Build anticipation. You can feel your DR around you. You're already there.

8. When it feels completely right, open your eyes - in your DR.

Tips:
• Focus intensely on the physical sensation of eyes
• Don't open your eyes until you genuinely feel you're there
• The anticipation is important - build it up
• Trust that your eyes will open to your DR
• Simple but requires strong conviction
• Great for those who've experienced shifting symptoms''',
      imageUrl:
          'https://images.unsplash.com/photo-1494869042583-f6c911f04b4c?w=800',
    ),
    ShiftingMethod(
      id: 'meditate',
      name: 'Meditation Method',
      category: 'Advanced',
      rating: 4.8,
      reviews: 1567,
      description:
          '''The Meditation Method uses deep meditation to reach a state conducive to shifting.

How to do it:

1. Sit or lie in a comfortable meditation position.

2. Begin with deep breathing. Inhale for 4 counts, hold for 4, exhale for 4.

3. Let your body fully relax. Release all tension.

4. Focus on your breath or a mantra until your mind is completely still.

5. In this deep meditative state, introduce thoughts of your DR.

6. Don't force visualization - just gently turn your awareness toward your DR.

7. Feel yourself dissolving from your CR and reforming in your DR.

8. Stay in meditation as long as needed until you feel fully shifted.

9. Open your eyes in your DR.

Tips:
• Meditation experience helps but isn't required
• The stillness of mind is crucial
• Don't force anything - let it happen
• Regular meditation practice helps shifting overall
• Can take longer but is very peaceful
• Great for patient, calm shifters''',
      imageUrl:
          'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800',
    ),
    ShiftingMethod(
      id: 'scroll',
      name: 'Fantasy Scroll',
      category: 'Visualization',
      rating: 4.7,
      reviews: 1432,
      description:
          '''The Fantasy Scroll Method uses the imagery of a magical scroll containing your DR.

How to do it:

1. Lie down and close your eyes. Enter a relaxed state.

2. Visualize yourself in a grand library or wizard's study filled with magical scrolls.

3. Find the scroll that contains your desired reality. It might glow or call to you.

4. Take the scroll and unroll it. Inside, you see your DR depicted in moving images.

5. Read about yourself in your DR - your life, your adventures, your relationships.

6. The scroll's magic pulls you in. Feel yourself being drawn into the parchment.

7. The images become life-sized, then real. You're inside the scroll's story.

8. The scroll's magic fades - you're now simply in your DR.

9. Open your eyes.

Tips:
• Great for fantasy DRs
• The library can have endless scrolls/realities
• The scroll makes your DR feel destined/fated
• Feel the magic pulling you in
• Good for Harry Potter or fantasy DRs
• You can always return to the library''',
      imageUrl:
          'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=800',
    ),
    ShiftingMethod(
      id: 'ocean',
      name: 'Ocean Method',
      category: 'Visualization',
      rating: 4.6,
      reviews: 1234,
      description:
          '''The Ocean Method uses the calming imagery of the ocean to help you shift.

How to do it:

1. Lie down and close your eyes. Listen to ocean sounds if available.

2. Visualize yourself floating in a warm, calm ocean under a starry sky.

3. Feel the gentle waves rocking you. You're safe and peaceful.

4. Begin to sink slowly beneath the surface. The water is warm and you can breathe easily.

5. As you sink deeper, you're moving between realities. The water is the space between worlds.

6. You see a light below you - it's your desired reality.

7. Swim toward the light. As you get closer, you begin to see your DR forming.

8. You emerge from the water into your DR - maybe on a beach, maybe somewhere else.

9. Open your eyes.

Tips:
• Ocean sounds help with this method
• The floating sensation is key
• The water represents the transition between realities
• Great for those who love the ocean
• Can be very calming and peaceful
• The emergence is like being reborn into your DR''',
      imageUrl:
          'https://images.unsplash.com/photo-1505142468610-359e7d316be0?w=800',
    ),
    ShiftingMethod(
      id: 'swingset',
      name: 'Swingset Method',
      category: 'Beginner',
      rating: 4.5,
      reviews: 876,
      description:
          '''The Swingset Method uses the nostalgic imagery of swinging to transition into your DR.

How to do it:

1. Lie down and close your eyes. Relax completely.

2. Visualize yourself sitting on a swing in a peaceful place.

3. Begin swinging gently back and forth. Feel the motion.

4. As you swing higher and higher, you notice the world around you changing.

5. Each swing forward takes you closer to your DR. Each swing back moves you further from your CR.

6. Eventually, you're swinging so high that you can see your DR ahead of you.

7. At the highest point of your swing, you jump off - and land in your DR.

8. Open your eyes.

Tips:
• The swinging motion can be very hypnotic
• Let yourself get lost in the rhythm
• The transition happens naturally as you swing
• Great for those who were children at heart
• The jump represents your commitment to shifting
• Very playful and lighthearted method''',
      imageUrl:
          'https://images.unsplash.com/photo-1519331379826-f10be5486c6f?w=800',
    ),
  ];
}

// ==================== MAIN SCREEN ====================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  String _userName = '';
  late List<ShiftingMethod> _methods;
  List<ShiftingMethod> _customMethods = [];
  List<Script> _scripts = [];

  @override
  void initState() {
    super.initState();
    _methods = getDefaultMethods();
  }

  void _updateUserName(String name) {
    setState(() => _userName = name);
  }

  void _addCustomMethod(ShiftingMethod method) {
    setState(() => _customMethods.add(method));
  }

  void _updateMethodAttempts(
      String methodId, List<Attempt> attempts, bool isCustom) {
    setState(() {
      if (isCustom) {
        final index = _customMethods.indexWhere((m) => m.id == methodId);
        if (index != -1) {
          _customMethods[index].attempts = attempts;
        }
      } else {
        final index = _methods.indexWhere((m) => m.id == methodId);
        if (index != -1) {
          _methods[index].attempts = attempts;
        }
      }
    });
  }

  void _addScript(Script script) {
    setState(() => _scripts.add(script));
  }

  void _updateScript(String id, String title, String content) {
    setState(() {
      final index = _scripts.indexWhere((s) => s.id == id);
      if (index != -1) {
        _scripts[index].title = title;
        _scripts[index].content = content;
        _scripts[index].updatedAt = DateTime.now();
      }
    });
  }

  void _deleteScript(String id) {
    setState(() => _scripts.removeWhere((s) => s.id == id));
  }

  // Export data to JSON file
  void _exportData() {
    final Map<String, dynamic> exportData = {
      'version': 1,
      'exportDate': DateTime.now().toIso8601String(),
      'userName': _userName,
      'methodAttempts': {
        for (var m in _methods.where((m) => m.attempts.isNotEmpty))
          m.id: m.attempts.map((a) => a.toJson()).toList()
      },
      'customMethods': _customMethods.map((m) => m.toJson()).toList(),
      'scripts': _scripts.map((s) => s.toJson()).toList(),
    };

    final jsonString = const JsonEncoder.withIndent('  ').convert(exportData);
    final bytes = utf8.encode(jsonString);
    final blob = html.Blob([bytes], 'application/json');
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement()
      ..href = url
      ..download =
          'shifting_reality_backup_${DateTime.now().millisecondsSinceEpoch}.json'
      ..click();

    html.Url.revokeObjectUrl(url);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Data exported successfully!'),
        backgroundColor: const Color(0xFF1A1A1A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // Import data from JSON file
  void _importData() {
    final input = html.FileUploadInputElement()..accept = '.json';
    input.click();

    input.onChange.listen((event) {
      final file = input.files?.first;
      if (file == null) return;

      final reader = html.FileReader();
      reader.readAsText(file);
      reader.onLoadEnd.listen((event) {
        try {
          final jsonString = reader.result as String;
          final Map<String, dynamic> data = json.decode(jsonString);

          setState(() {
            // Restore user name
            _userName = data['userName'] ?? '';

            // Restore method attempts
            final methodAttempts =
                data['methodAttempts'] as Map<String, dynamic>? ?? {};
            for (var method in _methods) {
              if (methodAttempts.containsKey(method.id)) {
                method.attempts = (methodAttempts[method.id] as List)
                    .map((a) => Attempt.fromJson(a))
                    .toList();
              }
            }

            // Restore custom methods
            _customMethods = (data['customMethods'] as List? ?? [])
                .map((m) => ShiftingMethod.fromJson(m))
                .toList();

            // Restore scripts
            _scripts = (data['scripts'] as List? ?? [])
                .map((s) => Script.fromJson(s))
                .toList();
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Data imported successfully!'),
              backgroundColor: Colors.green[700],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error importing data: $e'),
              backgroundColor: Colors.red[700],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      });
    });
  }

  void _showDataMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Text(
              'Backup & Restore',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Save your data to a file or restore from a backup',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _exportData();
                },
                icon: const Icon(Icons.download_rounded, size: 20),
                label: const Text('Save Backup',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A1A1A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _importData();
                },
                icon: const Icon(Icons.upload_rounded, size: 20),
                label: const Text('Restore Backup',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF1A1A1A),
                  side: const BorderSide(color: Color(0xFF1A1A1A), width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: [
              MethodsTab(
                userName: _userName,
                methods: _methods,
                customMethods: _customMethods,
                onUpdateUserName: _updateUserName,
                onAddCustomMethod: _addCustomMethod,
                onUpdateAttempts: _updateMethodAttempts,
                onShowDataMenu: _showDataMenu,
              ),
              ScriptsTab(
                scripts: _scripts,
                onAddScript: _addScript,
                onUpdateScript: _updateScript,
                onDeleteScript: _deleteScript,
              ),
              const Shifting101Tab(),
            ],
          ),
          // Floating black pill navigation bar
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(0, Icons.auto_awesome_outlined,
                      Icons.auto_awesome, 'Methods'),
                  _buildNavItem(1, Icons.description_outlined,
                      Icons.description, 'Script'),
                  _buildNavItem(2, Icons.school_outlined, Icons.school, '101'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
              size: 22,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color:
                    isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== METHODS TAB ====================

class MethodsTab extends StatefulWidget {
  final String userName;
  final List<ShiftingMethod> methods;
  final List<ShiftingMethod> customMethods;
  final Function(String) onUpdateUserName;
  final Function(ShiftingMethod) onAddCustomMethod;
  final Function(String, List<Attempt>, bool) onUpdateAttempts;
  final VoidCallback onShowDataMenu;

  const MethodsTab({
    super.key,
    required this.userName,
    required this.methods,
    required this.customMethods,
    required this.onUpdateUserName,
    required this.onAddCustomMethod,
    required this.onUpdateAttempts,
    required this.onShowDataMenu,
  });

  @override
  State<MethodsTab> createState() => _MethodsTabState();
}

class _MethodsTabState extends State<MethodsTab> {
  String _searchQuery = '';
  String _selectedCategory = 'Popular';
  final TextEditingController _searchController = TextEditingController();
  final PageController _pageController = PageController(viewportFraction: 0.85);

  final List<String> _categories = [
    'Popular',
    'Beginner',
    'Visualization',
    'Audio',
    'Advanced'
  ];

  List<ShiftingMethod> get _allMethods =>
      [...widget.methods, ...widget.customMethods];

  List<ShiftingMethod> get _filteredMethods {
    var methods = _allMethods;

    if (_searchQuery.isNotEmpty) {
      methods = methods
          .where(
              (m) => m.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    } else {
      methods = methods.where((m) => m.category == _selectedCategory).toList();
    }

    return methods;
  }

  void _showNameDialog() {
    final controller = TextEditingController(text: widget.userName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Enter Your Name', style: TextStyle(fontSize: 18)),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Your name',
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
          ),
          TextButton(
            onPressed: () {
              widget.onUpdateUserName(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save',
                style: TextStyle(
                    color: Color(0xFF1A1A1A), fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showAddMethodDialog() {
    final nameController = TextEditingController();
    final descController = TextEditingController();
    String selectedCategory = 'Popular';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title:
              const Text('Add Custom Method', style: TextStyle(fontSize: 18)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Method Name',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: _categories
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setDialogState(() => selectedCategory = value!),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  widget.onAddCustomMethod(ShiftingMethod(
                    id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
                    name: nameController.text,
                    description: descController.text,
                    category: selectedCategory,
                    imageUrl:
                        'https://images.unsplash.com/photo-1534796636912-3b95b3ab5986?w=800',
                    isCustom: true,
                  ));
                  Navigator.pop(context);
                }
              },
              child: const Text('Add',
                  style: TextStyle(
                      color: Color(0xFF1A1A1A), fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _showNameDialog,
                      child: Text(
                        'Hello, ${widget.userName.isEmpty ? 'Shifter' : widget.userName}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: widget.onShowDataMenu,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[100],
                              border: Border.all(
                                  color: Colors.grey[300]!, width: 1),
                            ),
                            child: Icon(Icons.cloud_outlined,
                                color: Colors.grey[600], size: 20),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: _showNameDialog,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.grey[300]!, width: 1),
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Search bar
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFFE8E8E8)),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _searchQuery = value),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle:
                          TextStyle(color: Colors.grey[400], fontSize: 15),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 8),
                        child: Icon(Icons.search,
                            color: Colors.grey[400], size: 20),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 40),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Select your method text with add button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select your method',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    GestureDetector(
                      onTap: _showAddMethodDialog,
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Category tabs
                SizedBox(
                  height: 32,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = category == _selectedCategory;
                      return GestureDetector(
                        onTap: () => setState(() {
                          _selectedCategory = category;
                          _searchQuery = '';
                          _searchController.clear();
                        }),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF1A1A1A)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            border: isSelected
                                ? null
                                : Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF666666),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Method cards - PageView style
          Expanded(
            child: _filteredMethods.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off,
                            size: 48, color: Colors.grey[300]),
                        const SizedBox(height: 12),
                        Text(
                          'No methods found',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : PageView.builder(
                    controller: _pageController,
                    itemCount: _filteredMethods.length,
                    itemBuilder: (context, index) {
                      final method = _filteredMethods[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8, bottom: 110),
                        child: MethodCard(
                          method: method,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MethodDetailPage(
                                method: method,
                                onUpdateAttempts: (attempts) =>
                                    widget.onUpdateAttempts(
                                  method.id,
                                  attempts,
                                  method.isCustom,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ==================== METHOD CARD ====================

class MethodCard extends StatelessWidget {
  final ShiftingMethod method;
  final VoidCallback onTap;

  const MethodCard({
    super.key,
    required this.method,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              Image.network(
                method.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 48, color: Colors.grey),
                ),
              ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.8),
                    ],
                    stops: const [0.0, 0.4, 0.7, 1.0],
                  ),
                ),
              ),

              // Content at bottom
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Method name
                    Text(
                      method.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Bottom row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Attempts count
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            '${method.attempts.length} attempts',
                            style: const TextStyle(
                              color: Color(0xFF1A1A1A),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        // See more button
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.3)),
                          ),
                          child: const Text(
                            'See more',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== METHOD DETAIL PAGE ====================

class MethodDetailPage extends StatefulWidget {
  final ShiftingMethod method;
  final Function(List<Attempt>) onUpdateAttempts;

  const MethodDetailPage({
    super.key,
    required this.method,
    required this.onUpdateAttempts,
  });

  @override
  State<MethodDetailPage> createState() => _MethodDetailPageState();
}

class _MethodDetailPageState extends State<MethodDetailPage> {
  late List<Attempt> _attempts;
  bool _isFavorite = false;
  bool _showFullDescription = false;

  @override
  void initState() {
    super.initState();
    _attempts = List.from(widget.method.attempts);
  }

  void _addAttempt() {
    final notesController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add Attempt',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: notesController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText:
                      'How did it go? Any symptoms? What could you improve?',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _attempts.add(Attempt(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        date: DateTime.now(),
                        notes: notesController.text,
                      ));
                    });
                    widget.onUpdateAttempts(_attempts);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Save Attempt',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editAttempt(Attempt attempt) {
    final notesController = TextEditingController(text: attempt.notes);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Edit Attempt',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: notesController,
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _attempts.removeWhere((a) => a.id == attempt.id);
                          });
                          widget.onUpdateAttempts(_attempts);
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text('Delete',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            final index =
                                _attempts.indexWhere((a) => a.id == attempt.id);
                            if (index != -1) {
                              _attempts[index].notes = notesController.text;
                            }
                          });
                          widget.onUpdateAttempts(_attempts);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A1A1A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: const Text('Save',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image
            Stack(
              children: [
                SizedBox(
                  height: 340,
                  width: double.infinity,
                  child: Image.network(
                    widget.method.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 48),
                    ),
                  ),
                ),

                // Top bar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.arrow_back_ios_new,
                                  size: 16, color: Color(0xFF1A1A1A)),
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    setState(() => _isFavorite = !_isFavorite),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    _isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 18,
                                    color: _isFavorite
                                        ? Colors.red
                                        : const Color(0xFF1A1A1A),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.ios_share,
                                    size: 18, color: Color(0xFF1A1A1A)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.method.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Category and rating
                  Row(
                    children: [
                      Icon(Icons.category_outlined,
                          size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        widget.method.category,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.star_rounded,
                          size: 16, color: Colors.amber[600]),
                      const SizedBox(width: 2),
                      Text(
                        widget.method.rating.toString(),
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.method.reviews} reviews',
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Description
                  Text(
                    _showFullDescription
                        ? widget.method.description
                        : widget.method.description.length > 250
                            ? '${widget.method.description.substring(0, 250)}...'
                            : widget.method.description,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.grey[700],
                    ),
                  ),
                  if (widget.method.description.length > 250)
                    GestureDetector(
                      onTap: () => setState(
                          () => _showFullDescription = !_showFullDescription),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          _showFullDescription ? 'Read less' : 'Read more',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),

                  // Your Attempts
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your Attempts',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      Text(
                        '${_attempts.length} total',
                        style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  if (_attempts.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.history,
                              size: 20, color: Colors.grey[400]),
                          const SizedBox(width: 12),
                          Text(
                            'No attempts yet. Try this method!',
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 14),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: _attempts.reversed.take(5).map((attempt) {
                        return GestureDetector(
                          onTap: () => _editAttempt(attempt),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.edit_note,
                                      size: 20, color: Colors.grey[600]),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _formatDate(attempt.date),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        attempt.notes.isEmpty
                                            ? 'No notes'
                                            : attempt.notes,
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 13),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.chevron_right,
                                    color: Colors.grey[400], size: 20),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: _addAttempt,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A1A1A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Add Attempt',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// ==================== SCRIPTS TAB ====================

class ScriptsTab extends StatelessWidget {
  final List<Script> scripts;
  final Function(Script) onAddScript;
  final Function(String, String, String) onUpdateScript;
  final Function(String) onDeleteScript;

  const ScriptsTab({
    super.key,
    required this.scripts,
    required this.onAddScript,
    required this.onUpdateScript,
    required this.onDeleteScript,
  });

  void _showAddScriptDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScriptEditorPage(
          onSave: (title, content) {
            onAddScript(Script(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: title,
              content: content,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'SCRIPTS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showAddScriptDialog(context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'Add Script',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: scripts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.description_outlined,
                              size: 32, color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No scripts yet',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tap "Add Script" to create your first script',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 14),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: scripts.length,
                    itemBuilder: (context, index) {
                      final script = scripts[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScriptEditorPage(
                              script: script,
                              onSave: (title, content) =>
                                  onUpdateScript(script.id, title, content),
                              onDelete: () => onDeleteScript(script.id),
                            ),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.article_outlined,
                                    color: Color(0xFF1A1A1A), size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      script.title,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      script.content,
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 13),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.chevron_right,
                                  color: Colors.grey[400], size: 20),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ==================== SCRIPT EDITOR PAGE ====================

class ScriptEditorPage extends StatefulWidget {
  final Script? script;
  final Function(String title, String content) onSave;
  final VoidCallback? onDelete;

  const ScriptEditorPage({
    super.key,
    this.script,
    required this.onSave,
    this.onDelete,
  });

  @override
  State<ScriptEditorPage> createState() => _ScriptEditorPageState();
}

class _ScriptEditorPageState extends State<ScriptEditorPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.script?.title ?? '');
    _contentController =
        TextEditingController(text: widget.script?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: const Icon(Icons.arrow_back_ios_new,
                color: Color(0xFF1A1A1A), size: 16),
          ),
        ),
        actions: [
          if (widget.onDelete != null)
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    title: const Text('Delete Script?',
                        style: TextStyle(fontSize: 18)),
                    content: const Text('This action cannot be undone.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel',
                            style: TextStyle(color: Colors.grey[600])),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.onDelete!();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Delete',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delete_outline,
                    color: Colors.red, size: 18),
              ),
            ),
          GestureDetector(
            onTap: () {
              if (_titleController.text.isNotEmpty) {
                widget.onSave(_titleController.text, _contentController.text);
                Navigator.pop(context);
              }
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: TextField(
                controller: _titleController,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                decoration: const InputDecoration(
                  hintText: 'Script Title',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(fontSize: 15, height: 1.6),
                  decoration: InputDecoration(
                    hintText:
                        'Write your shifting script here...\n\nInclude details about:\n• Your name and appearance in your DR\n• Where you live\n• People in your life\n• Your abilities\n• Your daily routine\n• Safe word to return',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== SHIFTING 101 TAB ====================

class Shifting101Tab extends StatelessWidget {
  const Shifting101Tab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SHIFTING 101',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Everything you need to know about reality shifting',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
            const SizedBox(height: 20),

            _buildInfoCard(
              'What is Reality Shifting?',
              '''Reality shifting is the practice of moving your consciousness from your current reality (CR) to your desired reality (DR). It's based on the multiverse theory - the idea that infinite realities exist simultaneously, each representing different possibilities and outcomes.

When you shift, you're not creating a new reality or traveling physically. Instead, you're moving your awareness to a version of yourself that already exists in another reality. Your consciousness shifts while your physical body remains in your CR.

Many shifters describe it as more vivid and real than lucid dreaming. In your DR, you have a full life, relationships, experiences, and memories. You can stay as long as you want and return to your CR whenever you choose.''',
              Icons.auto_awesome_outlined,
            ),

            _buildInfoCard(
              'The Science Behind It',
              '''While reality shifting isn't proven by mainstream science, many practitioners connect it to several theoretical concepts:

Multiverse Theory: Quantum physics suggests infinite parallel universes may exist, each with different versions of reality.

Consciousness Studies: Some researchers believe consciousness isn't limited to the brain and may be able to access different states or realities.

Neuroplasticity: The brain can create new neural pathways, potentially explaining why shifting techniques become easier with practice.

Quantum Mechanics: The observer effect in quantum physics suggests consciousness may influence reality at a fundamental level.

Meditation & Altered States: Shifting techniques share similarities with deep meditation and hypnosis, which are scientifically documented to alter brain states.''',
              Icons.science_outlined,
            ),

            _buildInfoCard(
              'How to Prepare',
              '''1. Create Your Script
Write detailed information about your DR including your appearance, relationships, abilities, location, and experiences. Include a safe word to return to your CR.

2. Believe It's Possible
Doubt is the biggest barrier. Know that shifting is real and achievable. Many people shift successfully every day.

3. Practice Meditation
Regular meditation improves focus and helps you reach the relaxed, receptive state needed for shifting.

4. Stay Consistent
Try shifting regularly. Most successful shifters attempted many times before their first shift.

5. Use Affirmations
Repeat positive statements like "I am a master shifter" or "Shifting is easy for me."

6. Visualize Your DR
Spend time imagining your DR in detail. The more real it feels, the easier shifting becomes.

7. Prepare Physically
Stay hydrated, get enough sleep, and try shifting when you're relaxed but not exhausted.''',
              Icons.checklist_outlined,
            ),

            _buildInfoCard(
              'Shifting Symptoms',
              '''As you approach a shift, you may experience:

Physical Sensations:
• Tingling or numbness in your body
• Feeling of floating or sinking
• Heart rate changes
• Temperature changes (feeling warm or cold)
• Vibrations throughout your body

Visual Experiences:
• Seeing bright lights or colors behind closed eyes
• Flashes of your DR scenes
• Patterns or geometric shapes

Auditory Signs:
• Hearing voices from your DR
• Music or sounds from your desired reality
• Ringing or buzzing in ears

Other Signs:
• Feeling a "pull" toward your DR
• Sense of detachment from your body
• Sensing the presence of DR people
• Feeling like you're in between realities

Not everyone experiences all symptoms, and some people shift with no symptoms at all. Don't worry if your experience is different!''',
              Icons.flash_on_outlined,
            ),

            _buildInfoCard(
              'Tips for Success',
              '''• Relax, Don't Force It
Shifting happens when you're in a relaxed, receptive state. Trying too hard can block the process.

• Use the Right Method
Different methods work for different people. Experiment to find what resonates with you.

• Shift When Drowsy
The hypnagogic state (between waking and sleeping) is ideal for shifting.

• Detach from Outcome
Trust the process. Obsessing over results creates anxiety that blocks shifting.

• Keep a Shift Journal
Document your attempts, symptoms, and progress to identify patterns.

• Join Communities
Connect with other shifters for support, tips, and motivation.

• Take Breaks
If you're frustrated, step back. Shifting should be enjoyable, not stressful.

• Use Subliminals
Many shifters find subliminal audio helpful for programming the subconscious.

• Stay Positive
Every attempt brings you closer. There's no such thing as a failed attempt - only practice.

• Trust Your Intuition
If a method or approach feels right, pursue it.''',
              Icons.tips_and_updates_outlined,
            ),

            _buildInfoCard(
              'Common Questions',
              '''Is shifting dangerous?
No. You cannot get stuck, and you can always return to your CR using your safe word or simply by intending to return.

Will I forget my CR?
No. You retain all CR memories. You may also choose to have DR memories in your script.

Can I shift anywhere?
Yes! Any reality you can imagine exists somewhere in the multiverse. Fictional worlds, historical periods, or custom realities.

How long can I stay?
As long as you want. Time in your DR doesn't have to match CR time - you can script time ratios.

What happens to my CR body?
It continues normally - sleeping, breathing, and safe. Some people script their clone to act on their behalf.

Can anyone shift?
Yes! Everyone has the ability. It's a skill anyone can develop with practice and patience.

Will I know I've shifted?
Most shifters report the experience feels real - not like a dream. You'll be fully conscious and present.

Can I bring things back?
Physically, no. But you can bring back memories, knowledge, and emotional experiences.''',
              Icons.help_outline,
            ),

            const SizedBox(height: 16),

            // Motivational card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.star_rounded, color: Colors.white, size: 32),
                  const SizedBox(height: 12),
                  const Text(
                    'You Are Already a Shifter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The reality you desire already exists. Your other self is waiting for you. Trust the process, stay consistent, and you will shift. Happy shifting!',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF1A1A1A), size: 20),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          children: [
            Text(
              content,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
