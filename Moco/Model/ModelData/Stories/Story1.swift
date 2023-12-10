//
//  Story1.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 19/11/23.
//

import Foundation

private let episode1 = EpisodeModel(
    pictureName: "Story/Content/Story1/Pages/Page1/background",
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
                    text: "_____,              _____,               ______\nsuka bermain bersama",
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
                    text: "Moco,              _____,               ______\nsuka bermain bersama",
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
                    text: "Moco,              Bebe,               ______\nsuka bermain bersama",
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
                    text: "Moco,              Bebe,               Teka & Teki\nsuka bermain bersama",
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
)

private let episode2 = EpisodeModel(
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
                    correctAnswer: "main",
                    startTime: 0,
                    promptType: PromptType.card,
                    hints: nil,
                    question: "Apakah kata yang memiliki arti melakukan permainan untuk menyenangkan hati?",
                    imageCard: "Story/Content/Story1/Pages/Page1/moco-card",
                    cardLocationX: 0.9,
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
                    yang banyak mengandung gula pada sarang lebah atau bunga (rasanya manis)?
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
                    cardLocationX: 0.85,
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
                    Apakah kata yang memiliki arti barang cair atau liat, dipakai untuk merekatkan sesuatu pada barang lain atau perekat?
                    """,
                    imageCard: "Story/Content/Story1/Pages/Page1/moco-card",
                    cardLocationX: 0.85,
                    cardLocationY: 0.38,
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
        )
    ],
    isAvailable: false
)

private let episode3 = EpisodeModel(
    pictureName: "",
    stories: [
        // Story page-1
        StoryModel(
            background: "Story/Content/Story1/Ep3/Page1/background",
            pageNumber: 1,
            isHavePrompt: true,
            prompts: [
                PromptModel(
                    correctAnswer: "Maze/answer_two",
                    startTime: 2,
                    promptType: PromptType.maze,
                    hints: nil,
                    question: """
                    Siapakah yang menyukai madu?
                    """,
                    answerChoices: [
                        "Beruang Madu",
                        "Sapi",
                        "Tikus"
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
            earlyPrompt: false
        ),
        // Story page-2
        StoryModel(
            background: "",
            pageNumber: 2,
            isHavePrompt: true,
            prompts: [
                PromptModel(
                    correctAnswer: "Maze/answer_glass",
                    startTime: 2,
                    promptType: PromptType.maze,
                    hints: nil,
                    question: """
                    Hewan apakah Moco?
                    """,
                    answerChoices: [
                        "Sapi",
                        "Katak",
                        "Tikus"
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
            background: "",
            pageNumber: 3,
            isHavePrompt: true,
            prompts: [
                PromptModel(
                    correctAnswer: "Maze/answer_mice",
                    startTime: 2,
                    promptType: PromptType.maze,
                    hints: nil,
                    question: """
                    Siapakah saudara dari Teka?
                    """,
                    answerChoices: [
                        "Teki",
                        "Moco",
                        "Bebe"
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
            background: "",
            pageNumber: 4,
            isHavePrompt: true,
            prompts: [
                PromptModel(
                    correctAnswer: "Maze/answer_mice",
                    startTime: 2,
                    promptType: PromptType.maze,
                    hints: nil,
                    question: """
                    Siapa yang bukan teman Moco?
                    """,
                    answerChoices: [
                        "Kato",
                        "Bebe",
                        "Teka"
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
            background: "",
            pageNumber: 5,
            isHavePrompt: true,
            prompts: [
                PromptModel(
                    correctAnswer: "Maze/answer_mice",
                    startTime: 2,
                    promptType: PromptType.maze,
                    hints: nil,
                    question: """
                    Karakter yang mirip Teka?
                    """,
                    answerChoices: [
                        "Teki",
                        "Kato",
                        "Moco"
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
            background: "Story/Content/Story1/Ep3/Page6/background",
            pageNumber: 6,
            isHavePrompt: true,
            prompts: [
                PromptModel(
                    correctAnswer: "luna",
                    startTime: 0,
                    promptType: PromptType.card,
                    hints: nil,
                    question: """
                    Siapakah seekor ular dewasa yang cerdik?
                    """,
                    imageCard: "",
                    cardLocationX: 0.4,
                    cardLocationY: 0.7,
                    cardType: CardType.character
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
            background: "Story/Content/Story1/Ep3/Page7/background",
            pageNumber: 7,
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
)

private let episode4 = EpisodeModel(
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
                    question: "Wow! kita sudah berada di pulau Arjuna. Sekarang, cari madu agar bisa menemukan Bebe!",
                    answerAssets: [
                        "honey_jar"
                    ] // meshes
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
                    perjalanan hari ini. Waktunya kita pulang, yuk cari alat yang dapat membawa \
                    kita kembali ke Kota Mocokerto!
                    """,
                    answerAssets: ["airplane"]
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
            enableUI: false,
            earlyPrompt: true
        )
    ],
    isAvailable: false
)

struct Story1: StoryProtocol {
    private(set) var slug = "story-1"

    var episodes: [EpisodeModel] {
        [
            episode1,
            episode2,
            episode3,
            episode4
        ]
    }
}
