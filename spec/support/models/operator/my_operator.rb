class MyOperator < Danica::Operator
  variables :x

  def to_f
    (x ** Danica::PI).to_f
  end

  def to_tex
    "#{x.to_tex}^{\\pi}"
  end

  def to_gnu
    "#{x.to_tex}**(pi)"
  end
end
