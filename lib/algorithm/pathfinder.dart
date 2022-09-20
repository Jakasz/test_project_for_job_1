class Pathfinder{
  //Посещенные клетки
  final _visitedNodes = [];
  //Флаг нахождения целевого элемента
  bool _isFound = false;
  //Массивы с нужными операторами для поиска соседних клетов
  //Эти 2 можно было обьеденить как 3й
  final _minusOperationArray = [-1, -1.1, -0.1, -0.9];
  final _plusOperationArray = [1, 1.1, 0.1, 0.9];
  final _fullOperators =[-1, -1.1, -0.1, -0.9, 1, 1.1, 0.1, 0.9];
  //Массивы по шагам поиска(1 волна, 2я волна, 3я волна)
  final _firstStep = [];
  final _secondStep = [];
  final _thirdStep = [];
  //результирующий массив
  final List _finalizedSteps = [];

   findPath(int startX, int startY, int endX, int endY) {
    var startValue = double.parse('$startX.$startY');
    var endValue = double.parse('$endX.$endY');
    //в мсассив посещенных заносим стартовое
    _visitedNodes.add(startValue);
    //проходим по шагам поиска 1
    _findNodes(startValue, endValue, _firstStep);
    //проходим по шагам поиска 2
    for (var element in _firstStep) {
      _findNodes(element, endValue, _secondStep);
    }
    //проходим по шагам поиска 3 если не нашли до этого момента
    if (!_isFound) {
      for (var element in _secondStep) {
        _findNodes(element, endValue, _thirdStep);
      }
    }
    //Поиск маршрута от отбратного(ищем с конечной точки по массивам
    //с шагами
    if (_isFound) {
     return _findFinalPath(endValue, startValue);
    }

  }

   _findFinalPath(double endXY, double startXY){
     //Найденный элемент с предыдущего массива шагов
     //так как ищем от обратного то ищем соседний в массиве предлыдущего шага
    double foundedValue = 0;
    _finalizedSteps.add(endXY);
    if (_thirdStep.contains(endXY)){
      for (var i = 0; i <= 7; i++) {
        final double fSearchValue = double.parse((endXY + _fullOperators[i]).toStringAsFixed(2));
        if (_secondStep.contains(fSearchValue)){
          _finalizedSteps.add(fSearchValue);
          foundedValue = fSearchValue;
          break;
        }
      }
    }
    //проверка на то что шагов было только 2
    if (foundedValue==0){
      foundedValue=endXY;
    }
    //Финальный поиск полного пути
    for (var i = 0; i <= 7; i++) {
      final double fSearchValue = double.parse((foundedValue + _fullOperators[i]).toStringAsFixed(2));
      if (_firstStep.contains(fSearchValue)){
        _finalizedSteps.add(fSearchValue);
        _finalizedSteps.add(startXY);
        //собсно результат
        return _finalizedSteps.reversed.toList();

      }
    }
  }
  void _findNodes(double startXY, double endXY, List stepArray) {
    //Массив со всеми точками для 4х4 матрицы
    final Set<double> allDots = {
      0.0,
      1.0,
      2.0,
      3.0,
      0.1,
      1.1,
      2.1,
      3.1,
      0.2,
      1.2,
      2.2,
      3.2,
      0.3,
      1.3,
      2.3,
      3.3
    };
    int stopValue = -1;
    // try {
    while (stopValue == -1) {
      //проверка всех "соседей" на наличие конечной точки
      //Нужно для проверки существования точки в матрице =>
      //=> allDots.where((element) => element==(startValue+-)) as double
      for (var i = 0; i <= 3; i++) {
        double minusSearchValue = double.parse((startXY + _minusOperationArray[i]).toStringAsFixed(2));
        ///Проверяем на нахождении массиве точек
        ///так как элемент может быть крайним в матрице то его значение может быть <0
        ///Так же сдесь была бы проверка на "стену". Стены я не сделал, увидел их
        ///только в jsone
        ///!!!!Создал бы еще массив с нодами стен и исключал бы запись в кратчайший маршрут!!!!!!!!!!!!!
        if (allDots.contains(minusSearchValue)) {
          if (!_visitedNodes.contains(minusSearchValue)) {
            _visitedNodes.add(minusSearchValue);
            stepArray.add(minusSearchValue);
            if (minusSearchValue==endXY){
              _isFound = true;
              break;
            }
          }
        }
      }
      for (var i = 0; i <= 3; i++) {
        double plusSearchValue = double.parse((startXY + _plusOperationArray[i]).toStringAsFixed(2));
        if (allDots.contains(plusSearchValue)) {
          if (!_visitedNodes.contains(plusSearchValue)) {
            _visitedNodes.add(plusSearchValue);
            stepArray.add(plusSearchValue);
            if (plusSearchValue==endXY){
              _isFound = true;
              break;
            }
          }
        }
      }
      //значени для остановки поиска
      stopValue = 1;
    }
  }

}