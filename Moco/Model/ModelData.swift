//
//  ModelData.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 04/11/23.
//

import Foundation

struct ModelData {
    static let dataToBePopulated: [String: [StoryThemeModel]] = [
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
                                prompts: [
                                    PromptModel(
                                        correctAnswer: "moco",
                                        startTime: 0,
                                        promptType: PromptType.card,
                                        hints: nil,
                                        question: "Siapakah anak sapi yang lucu?",
                                        imageCard: "Story/Content/Story1/Pages/Page1/moco-card",
                                        cardLocationX: 0.25,
                                        cardLocationY: 0.57
                                    ),
                                    PromptModel(
                                        correctAnswer: "bebe",
                                        startTime: 0,
                                        promptType: PromptType.card,
                                        hints: nil,
                                        question: "Siapakah anak beruang yang polos?",
                                        imageCard: "Story/Content/Story1/Pages/Page1/bebe-card",
                                        cardLocationX: 0.5,
                                        cardLocationY: 0.57
                                    ),
                                    PromptModel(
                                        correctAnswer: "teka_teki",
                                        startTime: 0,
                                        promptType: PromptType.card,
                                        hints: nil,
                                        question: "Siapakah yang disebut kembar?",
                                        imageCard: "Story/Content/Story1/Pages/Page1/tekateki-card",
                                        cardLocationX: 0.75,
                                        cardLocationY: 0.57
                                    )
                                ],
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
                                        duration: 0,
                                        contentName: "bg-story",
                                        contentType: StoryContentType.text,
                                        text: "_____,              _____,               ______\nsuka bermain bersama.",
                                        positionX: 0.5,
                                        positionY: 0.9,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    ),
                                    StoryContentModel(
                                        duration: 0,
                                        contentName: "bg-story",
                                        contentType: StoryContentType.text,
                                        text: "Moco,              _____,               ______\nsuka bermain bersama.",
                                        positionX: 0.5,
                                        positionY: 0.9,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    ),
                                    StoryContentModel(
                                        duration: 0,
                                        contentName: "bg-story",
                                        contentType: StoryContentType.text,
                                        text: "Moco,              Bebe,               ______\nsuka bermain bersama.",
                                        positionX: 0.5,
                                        positionY: 0.9,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    ),
                                    StoryContentModel(
                                        duration: 0,
                                        contentName: "bg-story",
                                        contentType: StoryContentType.text,
                                        text: "Moco,              Bebe,               Teka & Teki\nsuka bermain bersama.",
                                        positionX: 0.5,
                                        positionY: 0.9,
                                        maxWidth: 0,
                                        color: "",
                                        fontSize: 0
                                    )
                                ],
                                earlyPrompt: true
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
                                background: "Story/Content/Story1/Ep2/Page1/background",
                                pageNumber: 1,
                                isHavePrompt: true,
                                prompts: [
                                    PromptModel(
                                        correctAnswer: "kato",
                                        startTime: 0,
                                        promptType: PromptType.card,
                                        hints: nil,
                                        question: "Siapakah nama katak yang dewasa?",
                                        imageCard: "Story/Content/Story1/Ep2/Page1/kato-card",
                                        cardLocationX: 0.25,
                                        cardLocationY: 0.33
                                    )
                                ],
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
                                background: "Story/Content/Story1/Ep2/Page2/background",
                                pageNumber: 2,
                                isHavePrompt: true,
                                prompts: [
                                    PromptModel(
                                        correctAnswer: "kato",
                                        startTime: 0,
                                        promptType: PromptType.card,
                                        hints: nil,
                                        question: "Apakah kata yang memiliki arti melakukan permainan untuk menyenangkan hati?",
                                        imageCard: "Story/Content/Story1/Pages/Page1/moco-card",
                                        cardLocationX: 0.8,
                                        cardLocationY: 0.33,
                                        cardType: CardType.verb
                                    )
                                ],
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
                                background: "Story/Content/Story1/Ep2/Page3/background",
                                pageNumber: 3,
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
                            ),
                            StoryModel(
                                background: "Story/Content/Story1/Ep2/Page4/background",
                                pageNumber: 4,
                                isHavePrompt: true,
                                prompts: [
                                    PromptModel(
                                        correctAnswer: "madu",
                                        startTime: 0,
                                        promptType: PromptType.card,
                                        hints: nil,
                                        question: """
                                        Apakah kata yang memiliki arti cairan
                                        yang banyak mengandung zat gula pada sarang lebah atau bunga (rasanya manis)?
                                        """,
                                        imageCard: "Story/Content/Story1/Pages/Page1/moco-card",
                                        cardLocationX: 0.8,
                                        cardLocationY: 0.33,
                                        cardType: CardType.noun
                                    )
                                ],
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
                                background: "Story/Content/Story1/Ep2/Page5/background",
                                pageNumber: 5,
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
                            ),
                            StoryModel(
                                background: "Story/Content/Story1/Ep2/Page6/background",
                                pageNumber: 6,
                                isHavePrompt: true,
                                prompts: [
                                    PromptModel(
                                        correctAnswer: "stoples",
                                        startTime: 0,
                                        promptType: PromptType.card,
                                        hints: nil,
                                        question: """
                                        Apakah kata yang memiliki arti tabung kaca atau plastik yang biasanya dipakai untuk menyimpan sesuatu?
                                        """,
                                        imageCard: "Story/Content/Story1/Pages/Page1/moco-card",
                                        cardLocationX: 0.8,
                                        cardLocationY: 0.33,
                                        cardType: CardType.noun
                                    )
                                ],
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
                                background: "Story/Content/Story1/Ep2/Page7/background",
                                pageNumber: 7,
                                isHavePrompt: true,
                                prompts: [
                                    PromptModel(
                                        correctAnswer: "lem",
                                        startTime: 0,
                                        promptType: PromptType.card,
                                        hints: nil,
                                        question: """
                                        Apakah kata yang memiliki arti barang cair atau liat, dipakai untuk merekatkan sesuatu pada barang lain/perekat?
                                        """,
                                        imageCard: "Story/Content/Story1/Pages/Page1/moco-card",
                                        cardLocationX: 0.8,
                                        cardLocationY: 0.33,
                                        cardType: CardType.noun
                                    )
                                ],
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
                                background: "Story/Content/Story1/Ep2/Page8/background",
                                pageNumber: 8,
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
                            ),
                            StoryModel(
                                background: "Story/Content/Story1/Ep2/Page9/background",
                                pageNumber: 9,
                                isHavePrompt: true,
                                prompts: [
                                    PromptModel(
                                        correctAnswer: "culik",
                                        startTime: 0,
                                        promptType: PromptType.card,
                                        hints: nil,
                                        question: """
                                        Apakah kata yang memiliki arti mencuri atau melarikan orang lain dengan maksud tertentu?
                                        """,
                                        imageCard: "Story/Content/Story1/Pages/Page1/moco-card",
                                        cardLocationX: 0.8,
                                        cardLocationY: 0.33,
                                        cardType: CardType.noun
                                    )
                                ],
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
                                background: "Story/Content/Story1/Ep2/Page10/background",
                                pageNumber: 10,
                                isHavePrompt: true,
                                prompts: [
                                    PromptModel(
                                        correctAnswer: "terowongan",
                                        startTime: 0,
                                        promptType: PromptType.card,
                                        hints: nil,
                                        question: """
                                        Apakah kata yang memiliki arti tembusan dalam tanah atau gunung?
                                        """,
                                        imageCard: "Story/Content/Story1/Pages/Page1/moco-card",
                                        cardLocationX: 0.8,
                                        cardLocationY: 0.33,
                                        cardType: CardType.noun
                                    )
                                ],
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
                                background: "Story/Content/Story1/Ep2/Page11/background",
                                pageNumber: 11,
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
                            ),
                        ],
                        isAvailable: true
                    ),
                    // Episode-3
                    EpisodeModel(
                        pictureName: "",
                        stories: [
                            // Story page-1
                            StoryModel(
                                background: "Story/Content/Story1/Pages/Page6/background",
                                pageNumber: 1,
                                isHavePrompt: true,
                                prompts: [
                                    PromptModel(
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
                                            "Dua",
                                            "Satu",
                                            "Tiga"
                                        ],
                                        answerAssets: [
                                            "Maze/answer_one",
                                            "Maze/answer_three"
                                        ]
                                    )
                                ],
                                storyContents: [
                                    StoryContentModel(
                                        duration: 0,
                                        contentName: "maze-bgm",
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
                                prompts: [
                                    PromptModel(
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
                                            "Kacamata Hitam",
                                            "Palu",
                                            "Tas Ransel"
                                        ],
                                        answerAssets: [
                                            "Maze/answer_hammer",
                                            "Maze/answer_backpack"
                                        ]
                                    )
                                ],
                                storyContents: [
                                    StoryContentModel(
                                        duration: 0,
                                        contentName: "maze-bgm",
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
                                prompts: [
                                    PromptModel(
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
                                            "Tikus",
                                            "Sapi",
                                            "Katak"
                                        ],
                                        answerAssets: [
                                            "Maze/answer_sapi_jantan",
                                            "Maze/answer_frog"
                                        ]
                                    )
                                ],
                                storyContents: [
                                    StoryContentModel(
                                        duration: 0,
                                        contentName: "maze-bgm",
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
                            // Story page-4
                            StoryModel(
                                background: "Story/Content/Story1/Pages/Page6/background",
                                pageNumber: 4,
                                isHavePrompt: false,
                                prompts: nil,
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
                    // Episode-4
                    EpisodeModel(
                        pictureName: "",
                        stories: [
                            // Story page-1 // benda ke-1 yg harus dicari
                            StoryModel(
                                background: "",
                                pageNumber: 1,
                                isHavePrompt: true,
                                prompts: [
                                    PromptModel(
                                        correctAnswer: "honey_jar", // object to be found
                                        startTime: 3,
                                        promptType: PromptType.ar,
                                        hints: nil,
                                        question: "Wow! kita sudah berada di pulau Arjuna. Sekarang, cari madu agar bisa menemukan Maudi!",
                                        answerAssets: [
                                            "honey_jar"
                                        ] // meshes
                                    )
                                ],
                                storyContents: [],
                                enableUI: false,
                                earlyPrompt: true
                            ),
                            StoryModel(
                                background: "",
                                pageNumber: 2,
                                isHavePrompt: true,
                                prompts: [
                                    PromptModel(
                                        correctAnswer: "key",
                                        startTime: 3,
                                        promptType: PromptType.ar,
                                        hints: nil,
                                        question: "Bagus! Kita telah menemukan dimana Bebe dikurung! Namun, pintunya terkunci. Mari kita cari sesuatu yang dapat membuka tempat Bebe dikurung!",
                                        answerAssets: ["key"]
                                    )
                                ],
                                storyContents: [],
                                enableUI: false,
                                earlyPrompt: true
                            ),
                            StoryModel(
                                background: "",
                                pageNumber: 3,
                                isHavePrompt: true,
                                prompts: [
                                    PromptModel(
                                        correctAnswer: "airplane",
                                        startTime: 3,
                                        promptType: PromptType.ar,
                                        hints: nil,
                                        question:
                                        """
                                        Yeay!! Kita berhasil menemukan Bebe! Betapa melelahkannya \
                                        perjalanan hari ini. Waktunya kita pulang, yuk mencari alat yang dapat membawa \
                                        kita kembali ke Kota Mocokerto!
                                        """,
                                        answerAssets: ["airplane"]
                                    )
                                ],
                                storyContents: [],
                                enableUI: false,
                                earlyPrompt: true
                            )
                        ],
                        isAvailable: true
                    )
                ],
                slug: "story-1"
            )
        ]
    ]
    
    static let dataToBePopulatedOld: [String: [StoryThemeModel]] = [
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
                                prompts: [
                                    PromptModel(
                                        correctAnswer: "0",
                                        startTime: 2,
                                        promptType: PromptType.card,
                                        hints: nil,
                                        question: """
                                                    Siapakah nama seekor anak sapi yang lucu?
                                                    A.) Moco
                                                    B.) Bebe
                                                    C.) Teka dan Teki
                                                    """
                                    ),
                                ],
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
                                background: "Story/Content/Story1/Pages/Page2/background",
                                pageNumber: 2,
                                isHavePrompt: true,
                                prompts: [
                                    PromptModel(
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
                                    )
                                ],
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
                                prompts: [
                                    PromptModel(
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
                                    )
                                ],
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
                                prompts: [
                                    PromptModel(
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
                                    )
                                ],
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
                                prompts: [],
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
                                prompts: [
                                    PromptModel(
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
                                            "Dua",
                                            "Satu",
                                            "Tiga"
                                        ],
                                        answerAssets: [
                                            "Maze/answer_one",
                                            "Maze/answer_three"
                                        ]
                                    )
                                ],
                                storyContents: [
                                    StoryContentModel(
                                        duration: 0,
                                        contentName: "maze-bgm",
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
                                prompts: [
                                    PromptModel(
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
                                            "Kacamata Hitam",
                                            "Palu",
                                            "Tas Ransel"
                                        ],
                                        answerAssets: [
                                            "Maze/answer_hammer",
                                            "Maze/answer_backpack"
                                        ]
                                    )
                                ],
                                storyContents: [
                                    StoryContentModel(
                                        duration: 0,
                                        contentName: "maze-bgm",
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
                                prompts: [
                                    PromptModel(
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
                                            "Tikus",
                                            "Sapi",
                                            "Katak"
                                        ],
                                        answerAssets: [
                                            "Maze/answer_sapi_jantan",
                                            "Maze/answer_frog"
                                        ]
                                    )
                                ],
                                storyContents: [
                                    StoryContentModel(
                                        duration: 0,
                                        contentName: "maze-bgm",
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
                                prompts: [],
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
                    // Episode-3
                    EpisodeModel(
                        pictureName: "",
                        stories: [
                            // Story page-1 // benda ke-1 yg harus dicari
                            StoryModel(
                                background: "",
                                pageNumber: 1,
                                isHavePrompt: true,
                                prompts: [
                                    PromptModel(
                                        correctAnswer: "honey_jar", // object to be found
                                        startTime: 3,
                                        promptType: PromptType.ar,
                                        hints: nil,
                                        question: "Wow! kita sudah berada di pulau Arjuna. Sekarang, cari madu agar bisa menemukan Maudi!",
                                        answerAssets: ["honey_jar"] // meshes
                                    )
                                ],
                                storyContents: [],
                                enableUI: false,
                                earlyPrompt: true
                            ),
                            StoryModel(
                                background: "",
                                pageNumber: 2,
                                isHavePrompt: true,
                                prompts: [
                                    PromptModel(
                                        correctAnswer: "key",
                                        startTime: 3,
                                        promptType: PromptType.ar,
                                        hints: nil,
                                        question: "Bagus! Kita telah menemukan dimana Bebe dikurung! Namun, pintunya terkunci. Mari kita cari sesuatu yang dapat membuka tempat Bebe dikurung!",
                                        answerAssets: ["key"]
                                    )
                                ],
                                storyContents: [],
                                enableUI: false,
                                earlyPrompt: true
                            ),
                            StoryModel(
                                background: "",
                                pageNumber: 3,
                                isHavePrompt: true,
                                prompts: [
                                    PromptModel(
                                        correctAnswer: "airplane",
                                        startTime: 3,
                                        promptType: PromptType.ar,
                                        hints: nil,
                                        question:
                                        """
                                        Yeay!! Kita berhasil menemukan Bebe! Betapa melelahkannya \
                                        perjalanan hari ini. Waktunya kita pulang, yuk mencari alat yang dapat membawa \
                                        kita kembali ke Kota Mocokerto!
                                        """,
                                        answerAssets: ["airplane"]
                                    )
                                ],
                                storyContents: [],
                                enableUI: false,
                                earlyPrompt: true
                            )
                        ],
                        isAvailable: true
                    )
                ],
                slug: "story-1"
            )
        ]
    ]
}
struct SkyBox {
    var px: String
    var py: String
    var pz: String
    var nx: String
    var ny: String
    var nz: String
}
