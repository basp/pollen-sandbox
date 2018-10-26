#lang pollen

This is the first paragraph with some inline ◊${\beta = 10} math.

And this should be the second paragraph that contains a little bit of ◊code{3 + 2 = 5} code. Let's make this paragraph a little bit longer and include a bit more of ◊${\beta = 2} so it starts to wrap to multiple lines. That way we can see if the line height settings are nice.

◊$${
    \begin{align}
    1234_{10} &= 1\cdot1000 + 2\cdot100 + 3\cdot10 + 4\\
              &= 1\cdot10^3 + 2\cdot10^2 + 3\cdot10 + 4
    \end{align}
}

Now this one should be the third paragraph but I'm not really sure how it will be rendered by Pollen though.

In this fourth paragraph we will see if the syntax highlighting works. Below is some C# code that is supposed to be highlighted.

◊pre{◊code[#:class "cs"]{
    static uint[] Multiply(uint[] a, uint[] b) { ... };

    var a = new uint[] { 1, 2, 3 };
    var b = new uint[] { 4, 5, 6 };

    Multiply(a, b).Dump();
}}

Not sure if there is an easier way to do this but in Racket, in order to get list of value, index pairs from a list we can define something like:

◊pre{◊code[#:class "racket"]{
    (define (indexed xs)
      [map (lambda (x i) (cons x i)) xs (range (length xs))])
}}