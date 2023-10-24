#import "@preview/ctheorems:1.0.0": *
#import "@preview/big-todo:0.2.0": *
#import "@preview/lovelace:0.1.0": *

// Mise en page

#set page(width: 16cm, height: auto, margin: 1.5cm)
#set heading(numbering: "1.1.")

#let last_num = (..nums) => nums.pos().last()

#let theorem = thmbox("théorème", "Théorème", fill: rgb("#eeffee"), base_level: 0)

#let corollary = thmbox(
  "corollaire",
  "Corrolaire",
  fill: rgb("#efe6ff")
)

#let definition = thmbox("définition", "Défintion", stroke: rgb("#68ff68") + 1pt, base_level: 1).with(numbering: last_num)

#let example = thmplain(
  "exemple",
  "Exemple",
  inset: 0.8em,
  fill: luma(245),
  breakable: false,
).with(numbering: last_num)

#let proof = thmplain(
  "preuve",
  "Preuve",
  base: "theorem",
  bodyfmt: body => [#body #h(1fr) $square$],
).with(numbering: none)

#let remark = thmplain(
    "remarque",
    "Remarque"
).with(numbering: none)

#let property = thmbox(
  "propriété",
  "Propriété",
  stroke: blue + 1pt,
  base_level: 1
).with(numbering: last_num)

#let usuel = thmplain(
  "résultat usuel",
  "Résultat usuel",
  inset: 0.8em,
  stroke: black + 0.5pt,
  breakable: false,
).with(numbering: none)

#let method = thmbox(
  "méthode",
  "Méthode",
  stroke: 1pt,
  base_level: 1
).with(numbering: last_num)

#let exercice(num, fait, exo) = {
  import emoji: checkmark, crossmark
  let mark = if fait {checkmark} else {crossmark}

  counter(heading).update(num -1)

  {
    set heading(numbering: nums => "Exercice "+ numbering("1", nums))
    [= #mark ]
  }
  
  
  [#exo]
}

// Mathématiques

#let fun(ED, EA, i, o) = $ inline(#ED) & --> #EA \ #i & arrow.bar.long #o $

#let Union = $op(union.big,
     limits: #true)$

#let ii = $upright(i)$
#let ee = $upright(e)$

#let Re = $ op("Re") $
#let Im = $ op("Im") $

#let result(r) = align(center, rect(r, stroke: rgb("#fd8a8a"), radius: 5pt))

#let sgn = $op("sgn")$
#let lna(x) = $ln abs(#x)$

#let interval(e1,e2, lo: false, ro: false) = {
  let l = if lo {$bracket.l$} else {$bracket.r$}
  let r = if ro {$bracket.r$} else {$bracket.l$}

  $lr(#l #e1, #e2 #r)$
}

#let cosh = $op("ch")$
#let sinh = $op("sh")$
#let tanh = $op("th")$

#let arccos = $op("Arccos")$
#let arcsin = $op("Arcsin")$
#let arctan = $op("Arctan")$
#let argsh = $op("Argsh")$

#let conjug(z) = $accent(#z, -)$

#let pm =$plus.minus$

#let va(u) = $accent(#u, ->)$

// Templates

#let template(title, doc) = {
  set text(lang: "fr")
  // set document(title: title)
  set par(justify: true)

  set page(
    header: align(right, title),
    numbering: "1/1"
  )

  show: thmrules
  show: setup-lovelace

  align(center, text(title, style: "italic", 24pt))

  doc
}

#let chapter(num, name, doc) = {
  let title = "Chapitre " + str(num) + " - " + str(name)

  show: doc => template(title, doc)

  set heading(
    numbering :(..nums) => {
      let lenght = nums.pos().len()
      if lenght != 1 {
        nums.pos()
        .slice(if lenght==2 {-1} else {-2})
        .map(str)
        .join(".")
      } else {numbering("I", nums.pos().last())}
    }
  )

  outline()

  doc
}

#let devoir(type, num,  doc) = {
  let title = "Devoir " + str(type) + " " + str(num)
  show: doc => template(title, doc)

  set enum(numbering: "(1.a)")

  doc
}

#let td(num, name, doc) = {
  let title = "TD" + str(num) + " - " + name
  show: doc => template(title, doc)

  set enum(numbering: "(1.a)")
  
  outline()
  
  doc
}
