$ ->
  engine = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value')
    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote:
      url: '/movies?term=%QUERY' # %QUERY で入力された値を取得できる。
      filter: (movies) ->
        $.map movies, (movie) ->
          id: movie.id
          value: movie.title

  )

  engine.initialize()

  $('.typeahead').typeahead(
    {
      highlight: true
      hint: true
      minLength: 2 # 2文字以上入力されたら絞込開始。
    },
    {
      name: "movies"
      displayKey: 'value'
      source: engine.ttAdapter()
    }
  ).on "typeahead:selected typeahead:autocomplete", (e, item) ->
    $(this).closest(".field").find(".hidden-movie-id").val item.id # 選択後に id を hidden field に設定する。
