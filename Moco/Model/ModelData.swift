//
//  ModelData.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 04/11/23.
//

import Foundation


struct ModelData {
    static let dataToBePopulated = [
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
                                    promptType: PromptType.multipleChoice,
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
                                        contentType: StoryContentType.audio,
                                        positionX: 0,
                                        positionY: 0,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    ),
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
                                    promptType: PromptType.multipleChoice,
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
                                        contentType: StoryContentType.audio,
                                        positionX: 0,
                                        positionY: 0,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    ),
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
                                    promptType: PromptType.multipleChoice,
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
                                        contentType: StoryContentType.audio,
                                        positionX: 0,
                                        positionY: 0,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    ),
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
                                    promptType: PromptType.multipleChoice,
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
                                        contentType: StoryContentType.audio,
                                        positionX: 0,
                                        positionY: 0,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    ),
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
                                        contentType: StoryContentType.audio,
                                        positionX: 0,
                                        positionY: 0,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    ),
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
                                    promptType: PromptType.maze,
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
                                        contentType: StoryContentType.audio,
                                        positionX: 0,
                                        positionY: 0,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    )
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
                                    promptType: PromptType.maze,
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
                                        contentType: StoryContentType.audio,
                                        positionX: 0,
                                        positionY: 0,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    )
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
                                    promptType: PromptType.maze,
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
                                        contentType: StoryContentType.audio,
                                        positionX: 0,
                                        positionY: 0,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    )
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
                                    promptType: PromptType.objectDetection,
                                    hints: nil
                                ),
                                storyContents: [
                                    StoryContentModel(
                                        duration: 0,
                                        contentName: "bg-story",
                                        contentType: StoryContentType.audio,
                                        positionX: 0,
                                        positionY: 0,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    ),
                                    StoryContentModel(
                                        duration: 9,
                                        contentName: "Aku berkaki empat, tetapi aku tidak bisa berjalan. Orang-orang biasanya duduk di atasku.\nSiapakah aku?",
                                        contentType: StoryContentType.text,
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
                                        contentType: StoryContentType.audio,
                                        positionX: 0,
                                        positionY: 0,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    ),
                                    StoryContentModel(
                                        duration: 5,
                                        contentName: "Saat langit sudah mulai gelap, Moco bertemu dengan Kakak Katak yang sedang kesulitan menangkap balon.",
                                        contentType: StoryContentType.text,
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
                                    promptType: PromptType.puzzle,
                                    hints: nil
                                ),
                                storyContents: [
                                    StoryContentModel(
                                        duration: 0,
                                        contentName: "bg-story",
                                        contentType: StoryContentType.audio,
                                        positionX: 0,
                                        positionY: 0,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    ),
                                    StoryContentModel(
                                        duration: 7,
                                        contentName: "Kakak Katak sedang mengumpulkan balon yang berwarna Merah. Yuk kita bantu Kakak Katak menangkap balon!",
                                        contentType: StoryContentType.text,
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
                                        contentType: StoryContentType.audio,
                                        positionX: 0,
                                        positionY: 0,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    ),
                                    StoryContentModel(
                                        duration: 12,
                                        contentName: "Matahari pun terbenam dan Moco merasa lelah." +
                                        "Moco memutuskan untuk beristirahat dan melanjutkan petualangannya esok hari.",
                                        contentType: StoryContentType.text,
                                        positionX: 0.67,
                                        positionY: 0.63,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    ),
                                    StoryContentModel(
                                        duration: 9,
                                        contentName: "Hari ini, Moco belajar bahwa petualangan bisa menjadi kesempatan untuk membantu teman-temannya.",
                                        contentType: StoryContentType.text,
                                        positionX: 0.67,
                                        positionY: 0.63,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    ),
                                    StoryContentModel(
                                        duration: 5,
                                        contentName: "Moco tidur dengan senyum di wajahnya, bermimpi tentang petualangan berikutnya.",
                                        contentType: StoryContentType.text,
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
                ],
                slug: "story-1"
            )
        ]
    ]
}
