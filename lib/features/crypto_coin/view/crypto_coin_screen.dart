//crypto_coin_details_bloc.dart — импортируется BLoC для управления состоянием детальной
//информации о криптовалюте.
//widgets.dart — импортируется виджет BaseCard, который используется для отображения информации.
//crypto_coins.dart — импортируется репозиторий AbstractCoinsRepository и модель данных CryptoCoin.
//flutter/material.dart — импортируется для использования виджетов Material Design.
//flutter_bloc — импортируется для работы с паттерном BLoC.
//get_it — импортируется для внедрения зависимостей.
import 'package:crypto_coins_list/features/crypto_coin/bloc/crypto_coin_details/crypto_coin_details_bloc.dart';
import 'package:crypto_coins_list/features/crypto_coin/widgets/widgets.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';



//CryptoCoinScreen — это StatefulWidget, который создает состояние _CryptoCoinScreenState
class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

//_CryptoCoinScreenState — это состояние для CryptoCoinScreen.
//Создается экземпляр CryptoCoinDetailsBloc, который принимает репозиторий 
//AbstractCoinsRepository через GetIt.I<AbstractCoinsRepository>().
class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  CryptoCoin? coin;

  final _coinDetailsBloc = CryptoCoinDetailsBloc(
    GetIt.I<AbstractCoinsRepository>(),
  );

  //В методе didChangeDependencies извлекаются аргументы, переданные при навигации на экран.
 //Аргументы должны быть объектом типа CryptoCoin.
 //Если аргументы не равны null и являются объектом CryptoCoin, они присваиваются переменной coin.
//Добавляется событие LoadCryptoCoinDetails в _coinDetailsBloc для загрузки детальной информации о криптовалюте.
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is CryptoCoin, 'You must provide String args');
    coin = args as CryptoCoin;
    _coinDetailsBloc.add(LoadCryptoCoinDetails(currencyCode: coin!.name));
    super.didChangeDependencies();
  }

  //Метод build возвращает Scaffold, который содержит AppBar и BlocBuilder.
 //AppBar отображается в верхней части экрана.
 //BlocBuilder используется для построения UI на основе текущего состояния CryptoCoinDetailsState.
 //Если состояние CryptoCoinDetailsLoaded, отображается детальная информация о криптовалюте:
 //Изображение криптовалюты.
//Имя криптовалюты.
 //Цена криптовалюты в USD.
//Максимальная и минимальная цена за последние 24 часа.
 //В противном случае отображается CircularProgressIndicator для индикации загрузки.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CryptoCoinDetailsBloc, CryptoCoinDetailsState>(
        bloc: _coinDetailsBloc,
        builder: (context, state) {
          if (state is CryptoCoinDetailsLoaded) {
            final coinDetails = state.coinDetails;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: Image.network(coinDetails.imageURL),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    coinDetails.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  BaseCard(
                    child: Center(
                      child: Text(
                        '${coinDetails.priceInUSD} \$',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  BaseCard(
                    child: Column(
                      children: [
                        _DataRow(
                          title: 'Hight 24 Hour',
                          value: '${coinDetails.hight24Hour} \$',
                        ),
                        const SizedBox(height: 6),
                        _DataRow(
                          title: 'Low 24 Hour',
                          value: '${coinDetails.low24Hours} \$',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

//Класс _DataRow реализует виджет для отображения строки данных.
//Конструктор класса принимает два обязательных параметра: title и value.
//Метод build возвращает Row, который отображает заголовок и значение:
//Заголовок отображается в SizedBox с фиксированной шириной.
//Значение отображается в Flexible, что позволяет ему занимать оставшееся пространство.
class _DataRow extends StatelessWidget {
  const _DataRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 140, child: Text(title)),
        const SizedBox(width: 32),
        Flexible(
          child: Text(value),
        ),
      ],
    );
  }
}

//Этот код реализует экран CryptoCoinScreen, который отображает детальную информацию
//о криптовалюте. Он использует паттерн BLoC для управления состоянием и обновления UI
//в зависимости от текущего состояния. Экран извлекает аргументы, переданные при навигации,
//и использует их для загрузки детальной информации о криптовалюте. 
//В зависимости от результата загрузки, экран отображает индикатор загрузки или 
//детальную информацию о криптовалюте.