@REQ_MARVEL_API @HU004 @characters_deletion @marvel_characters_api @Agente2 @E2 @iniciativa_Marvel
Feature: Eliminación de personajes Marvel

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

  @id:1 @eliminarPersonaje @solicitudExitosa204
  Scenario: T-API-MARVEL-CA09-Eliminar personaje exitosamente 204 - karate
    # Creamos un personaje específico para eliminarlo con nombre aleatorio
    * def character = testData.characters.hulk
    * def randomId = java.util.UUID.randomUUID().toString().substring(0, 8)
    * set character.name = 'Hulk-Para-Eliminar-' + randomId

    And request character
    When method POST
    Then status 201
    * def deleteId = response.id

    # Verificamos que el personaje existe antes de eliminarlo
    Given path deleteId
    When method GET
    Then status 200

    # Eliminamos el personaje creado
    Given path deleteId
    When method DELETE
    Then status 204

    # Verificamos que el personaje ya no existe
    Given path deleteId
    When method GET
    Then status 404
    # And match response.error == "Character not found"
    # And match response != null

  @id:2 @eliminarPersonajeInexistente @noEncontrado404
  Scenario: T-API-MARVEL-CA10-Eliminar personaje inexistente 404 - karate
    # Usamos un ID fijo que no debería existir
    Given path '999'
    When method DELETE
    Then status 404
    # And match response.error == "Character not found"
    # And match response != null
