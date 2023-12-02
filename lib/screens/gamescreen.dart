import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool oturn = true;
  List<String> display = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  int oscore = 0;
  int xscore = 0;
  int fillbox = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "player X",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      xscore.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "player O",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      oscore.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            )),
          )),
          Expanded(
            flex: 5,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      ontapp(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade700)),
                      child: Center(
                        child: Text(
                          display[index],
                          style: const TextStyle(color: Colors.white,fontSize: 30),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void ontapp(int index) {
    setState(() {
      if (oturn && display[index] == '') {
        display[index] = 'o';
        fillbox += 1;
      } else if (!oturn && display[index] == '') {
        display[index] = 'x';
        fillbox += 1;
      }
      oturn = !oturn;
      checkwinner();
    });
  }

  void checkwinner() {
// checks 1st row
    if (display[0] == display[1] &&
        display[0] == display[2] &&
        display[0] != '') {
      showWinDialog(display[0]);
    }

    // checks 2nd row
    if (display[3] == display[4] &&
        display[3] == display[5] &&
        display[3] != '') {
      showWinDialog(display[3]);
    }

    // checks 3rd row
    if (display[6] == display[7] &&
        display[6] == display[8] &&
        display[6] != '') {
      showWinDialog(display[6]);
    }

    // checks 1st column
    if (display[0] == display[3] &&
        display[0] == display[6] &&
        display[0] != '') {
      showWinDialog(display[0]);
    }

    // checks 2nd column
    if (display[1] == display[4] &&
        display[1] == display[7] &&
        display[1] != '') {
      showWinDialog(display[1]);
    }

    // checks 3rd column
    if (display[2] == display[5] &&
        display[2] == display[8] &&
        display[2] != '') {
      showWinDialog(display[2]);
    }

    // checks diagonal
    if (display[6] == display[4] &&
        display[6] == display[2] &&
        display[6] != '') {
      showWinDialog(display[6]);
    }

    // checks diagonal
    if (display[0] == display[4] &&
        display[0] == display[8] &&
        display[0] != '') {
      showWinDialog(display[0]);
    } else if (fillbox == 9) {
      showdrawDialog();
    }
  }

  void showdrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("DRAW "),
          actions: [
            TextButton(
                onPressed: () {
                  clearboard();
                  Navigator.of(context).pop();
                },
                child: Text("Play Again"))
          ],
        );
      },
    );
  }

  void showWinDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("winner is: " + winner),
          actions: [
            TextButton(
                onPressed: () {
                  clearboard();
                  Navigator.of(context).pop();
                },
                child: Text("Play Again"))
          ],
        );
      },
    );
    if (winner == 'x') {
      xscore += 1;
    } else if (winner == 'o') {
      oscore += 1;
    }
  }

  void clearboard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        display[i] = '';
      }
    });
    fillbox = 0;
  }
}
