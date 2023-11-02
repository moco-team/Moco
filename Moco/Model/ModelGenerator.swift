//
//  ModelGenerator.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/10/23.
//

import SwiftData
import SwiftUI

struct ModelGenerator {
    private static let models: [any PersistentModel.Type] = [
        Item.self,
        CollectionModel.self,
        StoryThemeModel.self,
        EpisodeModel.self,
        StoryModel.self,
        StoryContentModel.self,
        PromptModel.self,
        HintModel.self
    ]
    
    @MainActor static func populateContainer<T: CustomPersistentModel>(container: ModelContainer, items: [T]) {
        let modelFetchDescriptor = FetchDescriptor<T>()
        let modelContext = ModelContext(container)
        
        do {
            let res = try modelContext.fetch(modelFetchDescriptor)
            
            // MARK: - This code will only run if the persistent store is empty.
            
            for item in items {
                if res.contains(where: {
                    $0.slug == item.slug
                }) {
                    modelContext.delete(res.first {
                        $0.slug == item.slug
                    }!)
                }
                modelContext.insert(item)
            }
            try? modelContext.save()
        } catch {
            print("Cannot populate container")
        }
    }
    
    @MainActor
    static let generator = { (inMemory: Bool) in
        let schema = Schema(models)
        let modelConfiguration = inMemory ?
        ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory, cloudKitDatabase: .none) :
        ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)
        
        
        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            // !!!: TO BE POPULATED, A MODEL MUST IMPLEMENT CustomPersistentModel
            let dataToBePopulated = [
                "storyThemeModel": [
                    // Story theme-1
                    StoryThemeModel(
                        pictureName: "Story/Cover/Story1",
                        episodes: [
                            // Episode-1
                            EpisodeModel(
                                pictureName: "",
                                stories: [
                                    // Story page-1
                                    StoryModel(
                                        background: "Story/Content/Story1/Pages/Page1/background",
                                        pageNumber: 1,
                                        isHavePrompt: true,
                                        prompt: PromptModel(
                                            correctAnswer: "0",
                                            startTime: 2,
                                            promptType: PromptType.multipleChoice.rawValue,
                                            hints: nil,
                                            question: """
            Siapakah nama seekor anak sapi yang lucu?
            A.) Moco
            B.) Bebe
            C.) Teka dan Teki
            """
                                        ),
                                        storyContents: [
                                            StoryContentModel(
                                                duration: 0,
                                                contentName: "bg-story",
                                                contentType: StoryContentType.audio.rawValue,
                                                positionX: 0,
                                                positionY: 0,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 0,
                                            //                                                contentName: "moco-1-1",
                                            //                                                contentType: StoryContentType.lottie.rawValue,
                                            //                                                positionX: Screen.width * 0.65,
                                            //                                                positionY: Screen.height * 0.6,
                                            //                                                maxWidth: 0,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 2.5,
                                            //                                                contentName: "Moco, Bebe, Teka, dan Teki merupakan sahabat yang karib." +
                                            //                                                "Moco merupakan seekor anak sapi yang lucu. Bebe adalah seekor anak beruang yang polos." +
                                            //                                                "Sedangkan, si kembar teka-teki merupakan dua anak tikus yang buta." +
                                            //                                                "Suatu hari, mereka pergi berpetualang bersama.",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.31,
                                            //                                                positionY: 0.15,
                                            //                                                maxWidth: 0,
                                            //                                                color: "",
                                            //                                                fontSize: 20
                                            //                                            )
                                        ]
                                    ),
                                    // Story page-2
                                    StoryModel(
                                        background: "Story/Content/Story1/Pages/Page2/background",
                                        pageNumber: 2,
                                        isHavePrompt: true,
                                        prompt: PromptModel(
                                            correctAnswer: "2",
                                            startTime: 2,
                                            promptType: PromptType.multipleChoice.rawValue,
                                            hints: nil,
                                            question: """
            Mengapa Bebe tidak dapat mengeluarkan tangannya dari toples?
            A. Karena tangan Bebe terlalu besar
            B. Karena Kato merupakan katak yang jahat
            C. Karena toples tersebut berisi lem yang lengket
            """
                                        ),
                                        storyContents: [
                                            StoryContentModel(
                                                duration: 0,
                                                contentName: "bg-story",
                                                contentType: StoryContentType.audio.rawValue,
                                                positionX: 0,
                                                positionY: 0,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 0,
                                            //                                                contentName: "moco-1-2",
                                            //                                                contentType: StoryContentType.lottie.rawValue,
                                            //                                                positionX: Screen.width * 0.54,
                                            //                                                positionY: Screen.height * 0.6,
                                            //                                                maxWidth: Screen.width * 0.15,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 5,
                                            //                                                contentName: "Di perjalanannya, dia bertemu dengan teman-temannya yang membutuhkan bantuan.",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.31,
                                            //                                                positionY: 0.18,
                                            //                                                maxWidth: Screen.width * 0.4,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            )
                                        ]
                                    ),
                                    // Story page-3
                                    StoryModel(
                                        background: "Story/Content/Story1/Pages/Page3/background",
                                        pageNumber: 3,
                                        isHavePrompt: true,
                                        prompt: PromptModel(
                                            correctAnswer: "2",
                                            startTime: 2,
                                            promptType: PromptType.multipleChoice.rawValue,
                                            hints: nil,
                                            question: """
            Mengapa perjalanan mengejar Kato dan Bebe terpaksa berhenti?
            A. Karena Moco, Teka, dan Teki capek bermain kejar-kejaran
            B. Karena Kato dan Bebe sudah tidak asik untuk diajak bermain
            C. Karena Moco, Teka, dan Teki merupakan hewan darat
            """
                                        ),
                                        storyContents: [
                                            StoryContentModel(
                                                duration: 0,
                                                contentName: "bg-story",
                                                contentType: StoryContentType.audio.rawValue,
                                                positionX: 0,
                                                positionY: 0,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 0,
                                            //                                                contentName: "maudi",
                                            //                                                contentType: StoryContentType.lottie.rawValue,
                                            //                                                positionX: Screen.width * 0.6,
                                            //                                                positionY: Screen.height * 0.6,
                                            //                                                maxWidth: 0,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            )
                                            //                                            StoryContentModel(
                                            //                                                duration: 4,
                                            //                                                contentName: "Saat menjelajahi hutan rimba, ",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.3,
                                            //                                                positionY: 0.17,
                                            //                                                maxWidth: Screen.width * 0.4,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 5,
                                            //                                                contentName: "dia bertemu Maudi si Beruang madu yang sedang menangis.",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.3,
                                            //                                                positionY: 0.17,
                                            //                                                maxWidth: Screen.width * 0.4,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 4,
                                            //                                                contentName: "Mari kita tanya mengapa Maudi menangis.",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.3,
                                            //                                                positionY: 0.13,
                                            //                                                maxWidth: Screen.width * 0.4,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 2,
                                            //                                                contentName: "Apa yang sedang dilakukan Maudi?",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.3,
                                            //                                                positionY: 0.13,
                                            //                                                maxWidth: Screen.width * 0.4,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                        ]
                                    ),
                                    // Story page-4
                                    StoryModel(
                                        background: "Story/Content/Story1/Pages/Page4/background",
                                        pageNumber: 3,
                                        isHavePrompt: true,
                                        prompt: PromptModel(
                                            correctAnswer: "1",
                                            startTime: 2,
                                            promptType: PromptType.multipleChoice.rawValue,
                                            hints: nil,
                                            question: """
            Bagaimana perasaan Moco ketika ia kehilangan seluruh teman berpetualangnya?
            A. Moco merasa senang
            B. Moco merasa sedih
            C. Moco merasa lapar
            """
                                        ),
                                        storyContents: [
                                            StoryContentModel(
                                                duration: 0,
                                                contentName: "bg-story",
                                                contentType: StoryContentType.audio.rawValue,
                                                positionX: 0,
                                                positionY: 0,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 0,
                                            //                                                contentName: "maudi",
                                            //                                                contentType: StoryContentType.lottie.rawValue,
                                            //                                                positionX: Screen.width * 0.6,
                                            //                                                positionY: Screen.height * 0.6,
                                            //                                                maxWidth: 0,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            )
                                            //                                            StoryContentModel(
                                            //                                                duration: 4,
                                            //                                                contentName: "Saat menjelajahi hutan rimba, ",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.3,
                                            //                                                positionY: 0.17,
                                            //                                                maxWidth: Screen.width * 0.4,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 5,
                                            //                                                contentName: "dia bertemu Maudi si Beruang madu yang sedang menangis.",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.3,
                                            //                                                positionY: 0.17,
                                            //                                                maxWidth: Screen.width * 0.4,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 4,
                                            //                                                contentName: "Mari kita tanya mengapa Maudi menangis.",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.3,
                                            //                                                positionY: 0.13,
                                            //                                                maxWidth: Screen.width * 0.4,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 2,
                                            //                                                contentName: "Apa yang sedang dilakukan Maudi?",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.3,
                                            //                                                positionY: 0.13,
                                            //                                                maxWidth: Screen.width * 0.4,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                        ]
                                    ),
                                    // Story page-5
                                    StoryModel(
                                        background: "Story/Content/Story1/Pages/Page5/background",
                                        pageNumber: 3,
                                        isHavePrompt: false,
                                        prompt: nil,
                                        storyContents: [
                                            StoryContentModel(
                                                duration: 0,
                                                contentName: "bg-story",
                                                contentType: StoryContentType.audio.rawValue,
                                                positionX: 0,
                                                positionY: 0,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 0,
                                            //                                                contentName: "maudi",
                                            //                                                contentType: StoryContentType.lottie.rawValue,
                                            //                                                positionX: Screen.width * 0.6,
                                            //                                                positionY: Screen.height * 0.6,
                                            //                                                maxWidth: 0,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 4,
                                            //                                                contentName: "Saat menjelajahi hutan rimba, ",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.3,
                                            //                                                positionY: 0.17,
                                            //                                                maxWidth: Screen.width * 0.4,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 5,
                                            //                                                contentName: "dia bertemu Maudi si Beruang madu yang sedang menangis.",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.3,
                                            //                                                positionY: 0.17,
                                            //                                                maxWidth: Screen.width * 0.4,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 4,
                                            //                                                contentName: "Mari kita tanya mengapa Maudi menangis.",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.3,
                                            //                                                positionY: 0.13,
                                            //                                                maxWidth: Screen.width * 0.4,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 2,
                                            //                                                contentName: "Apa yang sedang dilakukan Maudi?",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.3,
                                            //                                                positionY: 0.13,
                                            //                                                maxWidth: Screen.width * 0.4,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                        ]
                                    )
                                ],
                                isAvailable: true
                            ),
                            // Episode-2
                            EpisodeModel(
                                pictureName: "",
                                stories: [
                                    // Story page-1
                                    StoryModel(
                                        background: "Story/Content/Story1/Pages/Page6/background",
                                        pageNumber: 1,
                                        isHavePrompt: true,
                                        prompt: PromptModel(
                                            correctAnswer: "Maze/answer_one",
                                            startTime: 2,
                                            promptType: PromptType.maze.rawValue,
                                            hints: nil,
                                            question: """
“Berapakah jumlah teman yang sedang Moco cari di dalam terowongan?”
 A.) 1
 B.) 2
 C.) 3
""",
                                            answerChoices: [
                                                "Maze/answer_two",
                                                "Maze/answer_three"
                                            ]
                                        ),
                                        storyContents: [
                                            StoryContentModel(
                                                duration: 0,
                                                contentName: "bg-story",
                                                contentType: StoryContentType.audio.rawValue,
                                                positionX: 0,
                                                positionY: 0,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            )
                                            //                                            StoryContentModel(
                                            //                                                duration: 3.5,
                                            //                                                contentName: "Ternyata Maudi kehilangan madunya!",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.5,
                                            //                                                positionY: 0.3,
                                            //                                                maxWidth: 0,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 3.5,
                                            //                                                contentName: "Yuk bantu Maudi mencari madu kesayangannya!",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.5,
                                            //                                                positionY: 0.3,
                                            //                                                maxWidth: 0,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            )
                                        ]
                                    ),
                                    // Story page-2
                                    StoryModel(
                                        background: "Story/Content/Story1/Pages/Page6/background",
                                        pageNumber: 2,
                                        isHavePrompt: true,
                                        prompt: PromptModel(
                                            correctAnswer: "Maze/answer_one",
                                            startTime: 2,
                                            promptType: PromptType.maze.rawValue,
                                            hints: nil,
                                            question: """
“Benda apakah yang digunakan oleh Teka dan Teki?”
 A.) Tongkat
 B.) Tas Ransel
 C.) Kacamata Hitam
""",
                                            answerChoices: [
                                                "Maze/answer_two",
                                                "Maze/answer_three"
                                            ]
                                        ),
                                        storyContents: [
                                            StoryContentModel(
                                                duration: 0,
                                                contentName: "bg-story",
                                                contentType: StoryContentType.audio.rawValue,
                                                positionX: 0,
                                                positionY: 0,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            )
                                            //                                            StoryContentModel(
                                            //                                                duration: 3.5,
                                            //                                                contentName: "Ternyata Maudi kehilangan madunya!",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.5,
                                            //                                                positionY: 0.3,
                                            //                                                maxWidth: 0,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 3.5,
                                            //                                                contentName: "Yuk bantu Maudi mencari madu kesayangannya!",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.5,
                                            //                                                positionY: 0.3,
                                            //                                                maxWidth: 0,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            )
                                        ]
                                    ),
                                    // Story page-3
                                    StoryModel(
                                        background: "Story/Content/Story1/Pages/Page6/background",
                                        pageNumber: 3,
                                        isHavePrompt: true,
                                        prompt: PromptModel(
                                            correctAnswer: "Maze/answer_one",
                                            startTime: 2,
                                            promptType: PromptType.maze.rawValue,
                                            hints: nil,
                                            question: """
“Hewan apakah yang sedang Moco cari di dalam terowongan?”
 A.) Tikus
 B.) Sapi
 C.) Katak
""",
                                            answerChoices: [
                                                "Maze/answer_two",
                                                "Maze/answer_three"
                                            ]
                                        ),
                                        storyContents: [
                                            StoryContentModel(
                                                duration: 0,
                                                contentName: "bg-story",
                                                contentType: StoryContentType.audio.rawValue,
                                                positionX: 0,
                                                positionY: 0,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            )
                                            //                                            StoryContentModel(
                                            //                                                duration: 3.5,
                                            //                                                contentName: "Ternyata Maudi kehilangan madunya!",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.5,
                                            //                                                positionY: 0.3,
                                            //                                                maxWidth: 0,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 3.5,
                                            //                                                contentName: "Yuk bantu Maudi mencari madu kesayangannya!",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.5,
                                            //                                                positionY: 0.3,
                                            //                                                maxWidth: 0,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            )
                                        ]
                                    ),
                                ],
                                isAvailable: false
                            ),
                            // Episode-3
                            EpisodeModel(
                                pictureName: "",
                                stories: [
                                    // Story page-1
                                    StoryModel(
                                        background: "Story/Content/Story1/Pages/Page7/background",
                                        pageNumber: 1,
                                        isHavePrompt: true,
                                        prompt: PromptModel(
                                            correctAnswer: "",
                                            startTime: 3,
                                            promptType: PromptType.objectDetection.rawValue,
                                            hints: nil
                                        ),
                                        storyContents: [
                                            StoryContentModel(
                                                duration: 0,
                                                contentName: "bg-story",
                                                contentType: StoryContentType.audio.rawValue,
                                                positionX: 0,
                                                positionY: 0,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 9,
                                            //                                                contentName: "Aku berkaki empat, tetapi aku tidak bisa berjalan. Orang-orang biasanya duduk di atasku.\nSiapakah aku?",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.6,
                                            //                                                positionY: 0.3,
                                            //                                                maxWidth: 0,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 3.5,
                                            //                                                contentName: "Yuk bantu Maudi mencari madu kesayangannya!",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.5,
                                            //                                                positionY: 0.3,
                                            //                                                maxWidth: 0,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            )
                                            StoryContentModel(
                                                duration: 9,
                                                contentName: "Aku berkaki empat, tetapi aku tidak bisa berjalan. Orang-orang biasanya duduk di atasku.\nSiapakah aku?",
                                                contentType: StoryContentType.text.rawValue,
                                                positionX: 0.6,
                                                positionY: 0.3,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            )
                                        ]
                                    ),
                                    // Story page-2
                                    StoryModel(
                                        background: "Story/Content/Story1/Pages/Page8/background",
                                        pageNumber: 2,
                                        isHavePrompt: false,
                                        prompt: nil,
                                        storyContents: [
                                            StoryContentModel(
                                                duration: 0,
                                                contentName: "bg-story",
                                                contentType: StoryContentType.audio.rawValue,
                                                positionX: 0,
                                                positionY: 0,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 0,
                                            //                                                contentName: "kakak_katak",
                                            //                                                contentType: StoryContentType.lottie.rawValue,
                                            //                                                positionX: Screen.width * 0.54,
                                            //                                                positionY: Screen.height * 0.678,
                                            //                                                maxWidth: Screen.width * 0.35,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 5,
                                            //                                                contentName: "Saat langit sudah mulai gelap, Moco bertemu dengan Kakak Katak yang sedang kesulitan menangkap balon.",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.7,
                                            //                                                positionY: 0.15,
                                            //                                                maxWidth: 0,
                                            //                                                color: "#ffffff",
                                            //                                                fontSize: 0
                                            //                                            )
                                            StoryContentModel(
                                                duration: 5,
                                                contentName: "Saat langit sudah mulai gelap, Moco bertemu dengan Kakak Katak yang sedang kesulitan menangkap balon.",
                                                contentType: StoryContentType.text.rawValue,
                                                positionX: 0.7,
                                                positionY: 0.15,
                                                maxWidth: 0,
                                                color: "#FFFFFF",
                                                fontSize: 0
                                            )
                                        ]
                                    ),
                                    // Story page-3
                                    StoryModel(
                                        background: "Story/Content/Story1/Pages/Page9/background",
                                        pageNumber: 3,
                                        isHavePrompt: true,
                                        prompt: PromptModel(
                                            correctAnswer: "Jawaban yang benar adalah balon berwarna Merah",
                                            startTime: 3,
                                            promptType: PromptType.puzzle.rawValue,
                                            hints: nil
                                        ),
                                        storyContents: [
                                            StoryContentModel(
                                                duration: 0,
                                                contentName: "bg-story",
                                                contentType: StoryContentType.audio.rawValue,
                                                positionX: 0,
                                                positionY: 0,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 7,
                                            //                                                contentName: "Kakak Katak sedang mengumpulkan balon yang berwarna Merah. Yuk kita bantu Kakak Katak menangkap balon!",
                                            //                                                contentType: StoryContentType.text.rawValue,
                                            //                                                positionX: 0.6,
                                            //                                                positionY: 0.2,
                                            //                                                maxWidth: 0,
                                            //                                                color: "#ffffff",
                                            //                                                fontSize: 0
                                            //                                            )
                                            StoryContentModel(
                                                duration: 7,
                                                contentName: "Kakak Katak sedang mengumpulkan balon yang berwarna Merah. Yuk kita bantu Kakak Katak menangkap balon!",
                                                contentType: StoryContentType.text.rawValue,
                                                positionX: 0.6,
                                                positionY: 0.2,
                                                maxWidth: 0,
                                                color: "#FFFFFF",
                                                fontSize: 0
                                            )
                                        ]
                                    ),
                                    // Story page-4
                                    StoryModel(
                                        background: "Story/Content/Story1/Pages/Page10/background",
                                        pageNumber: 4,
                                        isHavePrompt: false,
                                        prompt: nil,
                                        storyContents: [
                                            StoryContentModel(
                                                duration: 0,
                                                contentName: "bg-story",
                                                contentType: StoryContentType.audio.rawValue,
                                                positionX: 0,
                                                positionY: 0,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            ),
                                            //                                            StoryContentModel(
                                            //                                                duration: 0,
                                            //                                                contentName: "moco-1-10",
                                            //                                                contentType: StoryContentType.lottie.rawValue,
                                            //                                                positionX: Screen.width * 0.22,
                                            //                                                positionY: Screen.height * 0.75,
                                            //                                                maxWidth: Screen.width * 0.35,
                                            //                                                color: "",
                                            //                                                fontSize: 0
                                            //                                            ),
                                            StoryContentModel(
                                                duration: 12,
                                                contentName: "Matahari pun terbenam dan Moco merasa lelah." +
                                                "Moco memutuskan untuk beristirahat dan melanjutkan petualangannya esok hari.",
                                                contentType: StoryContentType.text.rawValue,
                                                positionX: 0.67,
                                                positionY: 0.63,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            ),
                                            StoryContentModel(
                                                duration: 9,
                                                contentName: "Hari ini, Moco belajar bahwa petualangan bisa menjadi kesempatan untuk membantu teman-temannya.",
                                                contentType: StoryContentType.text.rawValue,
                                                positionX: 0.67,
                                                positionY: 0.63,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            ),
                                            StoryContentModel(
                                                duration: 5,
                                                contentName: "Moco tidur dengan senyum di wajahnya, bermimpi tentang petualangan berikutnya.",
                                                contentType: StoryContentType.text.rawValue,
                                                positionX: 0.67,
                                                positionY: 0.63,
                                                maxWidth: 0,
                                                color: "",
                                                fontSize: 0
                                            )
                                        ]
                                    )
                                ],
                                isAvailable: false
                            )
                        ]
                    )
                ]
            ]
            
            for (_, datum) in dataToBePopulated {
                ModelGenerator.populateContainer(container: container, items: datum)
            }
            
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
