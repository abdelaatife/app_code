import 'package:flutter/material.dart';

class measure extends StatefulWidget {
  const measure({Key? key}) : super(key: key);

  @override
  _measureState createState() => _measureState();
}

class _measureState extends State<measure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "asset/Union-2.png",
                ),
                opacity: 0.125)),
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Container(
                  child: Image.asset(
                    "asset/test-tube.gif",
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                 Text(
                  'Measure ',
                  style: TextStyle(
                      
                      fontSize: 32,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: const [
                Text(
                 'Use Device and place the tapes\nin their right place and press OK ',
                  style: TextStyle(
                    fontSize: 19,
                    height: 1.25,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Read The Guide  ',
                      style: TextStyle(
                        fontSize: 19,
                        height: 1.25,
                     
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      
                    ),
                    padding: const EdgeInsets.only(top: 17),
                    width: 260,
                    height: 50,
                    child: const Text(
                      'OK',
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
