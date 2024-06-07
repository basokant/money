import gleam/float
import gleam/int
import gleam/result
import gleam/order
import money/currency
import money/round

pub type Money {
  Money(currency: currency.Currency, amount: Int)
}

pub type MoneyError {
  FromCurrency(currency.CurrencyError)
  DivisorZero
}

pub fn new(currency_code: currency.ISOCurrencyCode, amount: Int) -> Money {
  let curr = currency.from_code(currency_code)
  Money(curr, amount)
}

pub fn from_float(
  currency_code: currency.ISOCurrencyCode,
  amount: Float,
) -> Money {
  let curr = currency.from_code(currency_code)
  let unit_factor = currency.get_unit_factor(curr)

  let rounded_amount =
    amount *. int.to_float(unit_factor)
    |> float.round()

  Money(curr, rounded_amount)
}

pub fn check_money(a: Money, b: Money) {
  let check = currency.check_currencies(a.currency, b.currency)

  case check {
    Error(x) -> Error(FromCurrency(x))
    Ok(Nil) -> Ok(Nil)
  }
}

pub fn compare(a: Money, with b: Money) -> Result(order.Order, MoneyError) {
  use _ <- result.try(check_money(a, b))
  Ok(int.compare(a.amount, b.amount))
}

pub fn add(augend: Money, addend: Money) -> Result(Money, MoneyError) {
  use _ <- result.try(check_money(augend, addend))
  let sum = augend.amount + addend.amount
  Ok(Money(augend.currency, sum))
}

pub fn subtract(minuend: Money, subtrahend: Money) -> Result(Money, MoneyError) {
  use _ <- result.try(check_money(minuend, subtrahend))
  let difference = minuend.amount - subtrahend.amount
  Ok(Money(minuend.currency, difference))
}

pub fn multiply(
  multiplier: Money,
  multiplicand: Money,
  rounding_mode: round.Mode,
) -> Result(Money, MoneyError) {
  use _ <- result.try(check_money(multiplier, multiplicand))

  let product = multiplier.amount * multiplicand.amount

  // TODO: Rounding Methods
  let rounded_product = todo

  Ok(Money(multiplier.currency, rounded_product))
}

fn check_divisor(divisor: Money) -> Result(Money, MoneyError) {
  case divisor.amount {
    0 -> Error(DivisorZero)
    _ -> Ok(divisor)
  }
}

pub fn division(
  dividend: Money,
  divisor: Money,
  rounding_mode: round.Mode,
) -> Result(Money, MoneyError) {
  use _ <- result.try(check_money(dividend, divisor))
  use _ <- result.try(check_divisor(divisor))

  let unit_factor = currency.get_unit_factor(dividend.currency)

  let quotient = dividend.amount / divisor.amount * unit_factor
  let remainder = dividend.amount % divisor.amount * unit_factor

  // TODO: Rounding Methods
  let rounded_quotient = todo

  Ok(Money(dividend.currency, rounded_quotient))
}
