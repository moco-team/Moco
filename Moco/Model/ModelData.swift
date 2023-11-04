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
                                    )
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
                                    )
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
                                    )
                                ]
                            ),
                            // Story page-4
                            StoryModel(
                                background: "Story/Content/Story1/Pages/Page4/background",
                                pageNumber: 4,
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
                                    )
                                ]
                            ),
                            // Story page-5
                            StoryModel(
                                background: "Story/Content/Story1/Pages/Page5/background",
                                pageNumber: 5,
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
                                    )
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
                                    correctAnswer: "Maze/answer_two",
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
                                        "Maze/answer_one",
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
                                ],
                                earlyPrompt: true
                            ),
                            // Story page-2
                            StoryModel(
                                background: "Story/Content/Story1/Pages/Page6/background",
                                pageNumber: 2,
                                isHavePrompt: true,
                                prompt: PromptModel(
                                    correctAnswer: "Maze/answer_glass",
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
                                        "Maze/answer_backpack",
                                        "Maze/answer_hammer"
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
                                ],
                                earlyPrompt: true
                            ),
                            // Story page-3
                            StoryModel(
                                background: "Story/Content/Story1/Pages/Page6/background",
                                pageNumber: 3,
                                isHavePrompt: true,
                                prompt: PromptModel(
                                    correctAnswer: "Maze/answer_mice",
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
                                        "Maze/answer_sapi_jantan",
                                        "Maze/answer_frog"
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
                                ],
                                earlyPrompt: true
                            ),
                            StoryModel(
                                background: "Story/Content/Story1/Pages/Page6/background",
                                pageNumber: 4,
                                isHavePrompt: false,
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
                            )
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
                                    promptType: PromptType.ar,
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
                                ],
                                enableUI: false, 
                                earlyPrompt: true
                            ),
                            StoryModel(
                                background: "Story/Content/Story1/Pages/Page7/background",
                                pageNumber: 2,
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
                        ],
                        isAvailable: false
                    )
                ],
                slug: "story-1"
            )
        ]
    ]
}
