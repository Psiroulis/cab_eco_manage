import 'package:cab_economics/helpers/caclulations_helper.dart';
import 'package:test/test.dart';

void main(){

  test('Calculate Commission for Ride', () {

    final value = CalculationHelper.calculateCommission(15, 100);

    expect(value, 15);

  });
}