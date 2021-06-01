class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question({this.id, this.question, this.answer, this.options});
}

const List sample_data = [
  {
    "id": 1,
    "question":
    "How many domestic sheep are there in the world?",
    "options": ['one billion', 'two billion', 'three billion', 'four billion'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "question": "An intact adult male sheep is called?",
    "options": ['Ram', 'Studly', 'Wether', 'Stallion'],
    "answer_index": 1,
  },
  {
    "id": 3,
    "question": "A castrated male sheep is a?",
    "options": ['Steer', 'Wether', 'Polled', 'Ram Lamb'],
    "answer_index": 2,
  },
  {
    "id": 4,
    "question": "Most sheep that graze on open graze land are a breed called?",
    "options": ['Hampshire', 'Suffolk', 'Rambouilet', 'Dorset'],
    "answer_index": 3,
  },
  {
    "id": 5,
    "question":
    "What is parturition in sheep called?",
    "options": ['lambing', 'eweing', 'farrowing', 'fouling'],
    "answer_index": 1,
  },
  {
    "id": 6,
    "question": "How long is the gestation of a sheep?",
    "options": ['4 weeks', '6 months', '9 months', '147 days8'],
    "answer_index": 4,
  },
  {
    "id": 7,
    "question": "What is the difference between a sheep and a goat- Sheep have?",
    "options": ['Wool', 'oil glands between toes', 'Horns', 'two milk teats'],
    "answer_index": 2,
  },
  {
    "id": 8,
    "question": "Sheep have____",
    "options": ['Round pupils', 'Rectangular pupils', 'Oval pupils', 'No pupils'],
    "answer_index": 2,
  },
  {
    "id": 9,
    "question":
    "What is the name of meat from sheep over two years old?",
    "options": ['Veal', 'Mutton', 'Lamb', 'Carne'],
    "answer_index": 2,
  },
  {
    "id": 10,
    "question": "The fine waviness in wool is called?",
    "options": ['crimp', 'staple', 'curls', 'luster'],
    "answer_index": 2,
  },
];
