//crypto_coin.dart — импортируется модель данных CryptoCoin, которая будет использоваться
// для отображения информации о криптовалюте.
//flutter/material.dart — импортируется для использования виджетов Material Design.
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter/material.dart';

//CryptoCoinTile — это StatelessWidget, который отображает информацию о криптовалюте в виде плитки (tile).

//Конструктор класса CryptoCoinTile принимает два параметра:
//super.key — ключ, который передается в базовый класс StatelessWidget.
//coin типа CryptoCoin — объект, содержащий информацию о криптовалюте.
//Параметр coin помечен как required, что означает, что он обязательный.


class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coin,
  });

  //Свойство coin типа CryptoCoin содержит информацию о криптовалюте, которая будет отображаться в виджете.
  final CryptoCoin coin;


  //Метод build возвращает ListTile, который отображает информацию о криптовалюте.
 //Theme.of(context) используется для получения текущей темы приложения.
 //ListTile имеет следующие свойства:
 //leading — отображает изображение криптовалюты с использованием Image.network(coin.imageURL).
 //title — отображает имя криптовалюты с использованием Text(coin.name, style: theme.textTheme.bodyMedium).
 //subtitle — отображает цену криптовалюты в USD с использованием Text('${coin.priceInUSD}\$', 
 //style: theme.textTheme.labelSmall).
//trailing — отображает иконку "стрелка вперед" с использованием const Icon(Icons.arrow_forward_ios).
//onTap — определяет действие, которое выполняется при нажатии на плитку. В данном случае, 
//происходит навигация на экран с деталями криптовалюты с 
//использованием Navigator.of(context).pushNamed('/coin', arguments: coin).
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Image.network(coin.imageURL),
      title: Text(
        coin.name,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        '${coin.priceInUSD}\$',
        style: theme.textTheme.labelSmall,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.of(context).pushNamed(
          '/coin',
          arguments: coin,
        );
      },
    );
  }
}
