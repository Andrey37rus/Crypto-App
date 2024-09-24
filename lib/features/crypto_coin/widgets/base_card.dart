import 'package:flutter/material.dart';

//BaseCard — это StatelessWidget, который представляет собой базовый виджет карточки. 
class BaseCard extends StatelessWidget {
  const BaseCard({super.key, required this.child});

  //Свойство child типа Widget содержит дочерний виджет, который будет отображаться внутри карточки. 
  final Widget child;

  //Метод build возвращает Container, который представляет собой карточку.
 //Container имеет следующие свойства:
 //margin — устанавливает отступы вокруг карточки с использованием 
 //EdgeInsets.symmetric(horizontal: 16, vertical: 8).
 //width — устанавливает ширину карточки на double.infinity, что означает, что
 // она будет занимать всю доступную ширину.
 //padding — устанавливает внутренние отступы внутри карточки с использованием EdgeInsets.all(16).
 //decoration — устанавливает декорацию карточки с использованием BoxDecoration:
 //borderRadius — устанавливает скругление углов карточки с использованием BorderRadius.circular(16).
 //color — устанавливает цвет фона карточки с использованием Color.fromARGB(255, 21, 21, 21).
 //child — устанавливает дочерний виджет, который будет отображаться внутри карточки. 
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(255, 21, 21, 21),
      ),
      child: child,
    );
  }
}


// Класс BaseCard реализует базовый виджет карточки, который может использоваться
// для отображения различной информации в приложении. Он принимает дочерний виджет 
// и отображает его внутри контейнера с заданными отступами, шириной, внутренними отступами и 
// декорацией. Этот виджет является частью пользовательского интерфейса и используется для 
// отображения информации в виде карточек.