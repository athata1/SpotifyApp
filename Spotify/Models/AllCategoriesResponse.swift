//
//  AllCategoriesResponse.swift
//  Spotify
//
//  Created by Akhil Thata on 5/25/23.
//

import Foundation

struct AllCategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}
struct Category: Codable {
    let name: String
    let id: String
    let icons: [APIImage]
}

//{
//    categories =     {
//        href = "https://api.spotify.com/v1/browse/categories?country=US&offset=0&limit=20";
//        items =         (
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/toplists";
//                icons =                 (
//                                        {
//                        height = 275;
//                        url = "https://t.scdn.co/media/derived/toplists_11160599e6a04ac5d6f2757f5511778f_0_0_275_275.jpg";
//                        width = 275;
//                    }
//                );
//                id = toplists;
//                name = "Top Lists";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFQ00XGBls6ym";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/original/hip-274_0a661854d61e29eace5fe63f73495e68_274x274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFQ00XGBls6ym;
//                name = "Hip-Hop";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFEC4WFtoNRpw";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/derived/pop-274x274_447148649685019f5e2a03a39e78ba52_0_0_274_274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFEC4WFtoNRpw;
//                name = Pop;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFKLfwjuJMoNC";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/a2e0ebe2ebed4566ba1d8236b869241f.jpeg";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFKLfwjuJMoNC;
//                name = Country;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFxXaXKP7zcDp";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/26a60378-a374-4cd7-b894-28efa5e154cb.jpg";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFxXaXKP7zcDp;
//                name = Latin;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFDXXwE9BDJAr";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/derived/rock_9ce79e0a4ef901bbd10494f5b855d3cc_0_0_274_274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFDXXwE9BDJAr;
//                name = Rock;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFLVaM30PMBm4";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/8e508d7eb5b843a89c368c9507ecc429.jpeg";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFLVaM30PMBm4;
//                name = Summer;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFAXlCG6QvYQ4";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/media/links/workout-274x274.jpg";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFAXlCG6QvYQ4;
//                name = Workout;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFEZPnFQSFB1T";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/derived/r-b-274x274_fd56efa72f4f63764b011b68121581d8_0_0_274_274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFEZPnFQSFB1T;
//                name = "R&B";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFHOzuVTgTizF";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/derived/edm-274x274_0ef612604200a9c14995432994455a6d_0_0_274_274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFHOzuVTgTizF;
//                name = "Dance/Electronic";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFEOEBCABAxo9";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/1a416fb97f5647858c7f09c9cb6e7301";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFEOEBCABAxo9;
//                name = Netflix;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFCWjUTdzaG0e";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/fe06caf056474bc58862591cd60b57fc.jpeg";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFCWjUTdzaG0e;
//                name = Indie;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFzHmL4tf05da";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/original/mood-274x274_976986a31ac8c49794cbdc7246fd5ad7_274x274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFzHmL4tf05da;
//                name = Mood;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFCuoRTxhYWow";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/derived/sleep-274x274_0d4f836af8fab7bf31526968073e671c_0_0_274_274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFCuoRTxhYWow;
//                name = Sleep;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFy0OenPG51Av";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/e023f691436b4518aec8c3b18973268e";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFy0OenPG51Av;
//                name = "Christian & Gospel";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFDTEtSaS4R92";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/c765fa1ce6994fce8796d2d0d93c1e61.jpeg";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFDTEtSaS4R92;
//                name = "Regional Mexican";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFLb2EqgLtpjC";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/3710b68657574bc79df14bd74629e5ac";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFLb2EqgLtpjC;
//                name = Wellness;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFFzDl7qN9Apr";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/derived/chill-274x274_4c46374f007813dd10b37e8d8fd35b4b_0_0_274_274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFFzDl7qN9Apr;
//                name = Chill;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFPw634sFwguI";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/084155aeaa724ea1bd393a017d67b709";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFPw634sFwguI;
//                name = EQUAL;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFCfObibaOZbv";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/0d39395309ba47838ef12ce987f19d16.jpeg";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFCfObibaOZbv;
//                name = Gaming;
//            }
//        );
//        limit = 20;
//        next = "https://api.spotify.com/v1/browse/categories?country=US&offset=20&limit=20";
//        offset = 0;
//        previous = "<null>";
//        total = 55;
//    };
//}
