@REQ_MARVEL_API @HU002 @characters_query @marvel_characters_api @Agente2 @E2 @iniciativa_Marvel
Feature: Consulta de personajes Marvel

  Background:
    * def testData = read('classpath:data/Marvel/test_data.json')
    * def baseUrl = testData.baseURL
    * def username = testData.username
    * url baseUrl + '/' + username + '/api/characters'
    * header Content-Type = 'application/json'
    * configure ssl = true
    * configure retry = { count: 3, interval: 5000 }
    * configure connectTimeout = 10000
    * configure readTimeout = 10000

  @id:1 @obtenerPersonajes @solicitudExitosa200
  Scenario: T-API-MARVEL-CA04-Obtener todos los personajes 200 - karate
    When method GET
    Then status 200
    # And match response != null
    # And match response[*].id != null

  @id:2 @obtenerPersonajeId @solicitudExitosa200
  Scenario: T-API-MARVEL-CA05-Obtener personaje por ID 200 - karate
    # Siempre usamos el ID fijo 4 para esta prueba
    * def characterId = 4
    Given path characterId
    When method GET
    Then status 200
    # And match response.id == characterId
    # And match response.name != null

  @id:3 @obtenerPersonajeInexistente @noEncontrado404
  Scenario: T-API-MARVEL-CA06-Obtener personaje inexistente 404 - karate
    Given path '999'
    When method GET
    Then status 404
    # And match response.error == "Character not found"
    # And match response != null
