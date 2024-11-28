//
//  TransformationModel.swift
//  KCDragonBallProf
//
//  Created by Kevin Heredia on 28/11/24.
//

import Foundation

struct TransformationModel: Codable {
    let name: String
    let description: String
    let photo: String
    let hero: HeroModel
}

struct HeroModel: Codable {
    let id: String
}

/*[
 {
     "description": "Es la fusión de  Krillin y Kid Goku que apareció por primera vez en Dragon Ball Fusions.",
     "name": "4. Gorilin",
     "photo": "https://areajugones.sport.es/wp-content/uploads/2020/03/Gorilin.jpg.webp",
     "hero": {
         "id": "D88BE50B-913D-4EA8-AC42-04D3AF1434E3"
     },
     "id": "616ADA79-EF94-41BE-B4ED-3A44A3F3E2B7"
 },
 {
     "description": "Es una transformación exclusiva que pudimos ver en los videojuegos Dragon Ball Z: Supersonic Warriors y Dragon Ball Xenoverse. Como ocurrió con Yamcha, esta transformación fue eliminada de la secuela. En el primero de los juegos forman una historia alrededor de la transformación. En ella Goku regresa al mundo de los vivos con Baba después de morir del corazón y le enseña a Krilin esta transformación y la Genkidama con el objetivo de que este defienda la Tierra.",
     "name": "2. Kaio-Ken",
     "photo": "https://areajugones.sport.es/wp-content/uploads/2020/03/kaiokenKrilin-1024x576.jpg.webp",
     "hero": {
         "id": "D88BE50B-913D-4EA8-AC42-04D3AF1434E3"
     },
     "id": "2DA215C2-72AB-4132-A917-8095BF041E9D"
 },
 {
     "description": "Prilin es una fusión hipotética entre Piccolo y Krillin que apareció por primera vez en el número 13 de la revista Weekly Shonen Jump. En la saga de Buu, se ve a Krillin y Piccolo interpretando la danza de la fusión como una demostración para que Goten y Trunks lo lograsen, por lo que Akira Toriyama dibujó una fusión hipotética entre los dos personajes como un guiño a ese preciso momento. Esta fusión fue simplemente un dibujo y nunca llegó al manga o al anime de forma oficial.",
     "name": "3. Prilin",
     "photo": "https://areajugones.sport.es/wp-content/uploads/2020/03/Prilin-1024x576.jpg.webp",
     "hero": {
         "id": "D88BE50B-913D-4EA8-AC42-04D3AF1434E3"
     },
     "id": "12E4851A-1944-44F9-97A0-F1266E8EB860"
 },
 {
     "description": "Esta transformación se introduce en Dragon Ball Super con el objetivo de volver a hacer al personaje algo más competitivo. Lo alcanza durante su entrenamiento con Goku en el Bosque del Terror. Krilin gana un nuevo poder al enfrentar sus miedos y controlar su corazón. El aura de Krilin no se dispersa como lo hace habitualmente, sino que toma forma alrededor de su cuerpo, evitando que nada de ki se desperdicie. En esta estado el personaje lucha más tarde contra Goku en SSB en una batalla que causó mucha polémica. A pesar de que se presentó como posible, en este estado el personaje sigue muy lejos de los niveles de poder del Saiyan.",
     "name": "1. No Ego",
     "photo": "https://areajugones.sport.es/wp-content/uploads/2020/03/NoegoKrillin-1024x576.jpg.webp",
     "hero": {
         "id": "D88BE50B-913D-4EA8-AC42-04D3AF1434E3"
     },
     "id": "CEC4FBF9-EF37-4773-A6AE-189DB2D92CE8"
 }
]*/
