import 'dart:math';

final inspirationalMessages = [
  'Fall in love with taking care of yourself ❤️',
  'Overcome your resistance to change 💪',
  'Secret of your future is hidden in your daily routine 🤝',
  'To change your life, change your habits 😊',
  'Be patient with yourself 🤟',
  'Your life doesn\'t get better by chance.It gets better by change 🙃',
  'Motivation is what gets you started.Habit is what keeps you going ✨',
  'Stop worrying about how it\'s going to happen & Start believing it will 🤠',
  'It takes 21 days to make or break a habit 🤓',
  'It is extremely hard to break Bad habits,and takes long time to start new healthy ones 🤗',
];

String getRandomInspirationalMessage() {
  final random = new Random();
  return inspirationalMessages[random.nextInt(inspirationalMessages.length)];
}
