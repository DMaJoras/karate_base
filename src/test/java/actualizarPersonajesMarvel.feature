@REQ_MARVEL_API @HU003 @characters_update @marvel_characters_api @Agente2 @E2 @iniciativa_Marvel
Feature: Actualización de personajes Marvel

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

  @id:1 @actualizarPersonaje @solicitudExitosa200
  Scenario: T-API-MARVEL-CA07-Actualizar personaje exitosamente 200 - karate
    # Siempre usamos el ID fijo 4 para esta prueba
    * def characterId = 4

    # Enviamos directamente los datos actualizados sin obtener primero el personaje
    * def updateData = testData.characters.ironMan
    * set updateData.name = "Iron Man Test"
    * set updateData.description = 'Descripción actualizada para pruebas automatizadas'
    * set updateData.alterego = "Tony Stark"
    * set updateData.powers = ["Armadura", "Vuelo", "Inteligencia"]

    Given path characterId
    And request updateData
    When method PUT
    Then status 200
    # And match response.description contains 'actualizada'
    # And match response.id == characterId

  @id:2 @actualizarPersonajeInexistente @noEncontrado404
  Scenario: T-API-MARVEL-CA08-Actualizar personaje inexistente 404 - karate
    * def character = testData.characters.ironMan
    * set character.name = "Iron Man Update Test"
    * set character.description = 'Intento actualizar personaje inexistente'

    Given path '999'
    And request character
    When method PUT
    Then status 404
    # And match response.error == "Character not found"
    # And match response != null
