@REQ_MARVEL_API @HU001 @characters_creation @marvel_characters_api @Agente2 @E2 @iniciativa_Marvel
Feature: Creación de personajes Marvel

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

  @id:1 @crearPersonaje @solicitudExitosa201
  Scenario: T-API-MARVEL-CA01-Crear personaje exitosamente 201 - karate
    * def character = testData.characters.ironMan
    * set character.name = "Iron Man Test"
    And request character
    When method POST
    Then status 201
    # And match response != null
    # And match response.id != null
    * def characterId = response.id
    * karate.write(characterId, 'target/characterId.txt')

  @id:2 @crearPersonaje @nombreDuplicado400
  Scenario: T-API-MARVEL-CA02-Crear personaje con nombre duplicado 400 - karate
    # Creamos un personaje inicial con nombre específico
    * def character = testData.characters.spiderMan
    * set character.name = 'Spider-Man-Duplicado'

    And request character
    When method POST
    Then status 201

    # Intentamos crear el mismo personaje otra vez con el mismo nombre
    And request character
    When method POST
    Then status 400
    # And match response.error contains 'Character name already exists'
    # And match response.error == "Character name already exists"

  @id:3 @crearPersonaje @datosInvalidos400
  Scenario: T-API-MARVEL-CA03-Crear personaje con datos inválidos 400 - karate
    * def invalidCharacter = { "name": "", "alterego": "", "description": "", "powers": [] }
    And request invalidCharacter
    When method POST
    Then status 400
    # And match response.name contains 'required'
    # And match response.alterego contains 'required'
