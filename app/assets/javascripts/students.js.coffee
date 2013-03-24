jQuery ->
  # performanceColor is derived in js
  $('.sparklines.average_score1').sparkline('html', {
    type:'bullet',
    tagValuesAttribute: 'data-values',
    height: '30px',
    performanceColor: gradeColor($(this).data('grade')),
    targetColor: 'orange',
    rangeColors: ['#CCFFCC', '#FFFF99', '#FF9999'],
    width: '200px'
  })
  # performanceColor is assigned in tag
  $('.sparklines.average_score2').sparkline('html', {
    type:'bullet',
    enableTagOptions: true,
    tagValuesAttribute: 'data-values',
    height: '30px',
    targetColor: 'orange',
    rangeColors: ['#CCFFCC', '#FFFF99', '#FF9999'],
    width: '200px'
  })
  $('.sparklines.grades').sparkline('html', { tagValuesAttribute: 'data-values'})

gradeColor = (grade) ->
  switch
    when grade >= 85 then 'green'
    when grade >= 60 then 'yellow'
    when grade <60   then 'red'
    else 'gray'

