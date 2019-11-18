︠2703af61-257f-402c-aad6-3cba961781bcs︠
# All of the functions are in a .sage file. Load them in, and use them here.
load("Classical_Cipher_Functions.sage")
︡eea7dd10-6450-4c21-8816-75a2b90afd98︡{"done":true}
︠5aca4385-947a-46d6-adae-2a5dba5718c9s︠
ciphertext = """eeqbfpgpntzkmzkeraelsajshoiwmrkvnerf
wnkhvealmfrczrqalqtincuotlvswomvnstz
qfqjklssobjicbsetzirktwpixrwyawwbwnk
hrrnuifjqieqtynrbzksrslstcy""".replace('\n','').lower()
ciphertext = """
HBGXXLDSWVQLLAISYMQPMUIOYXCXYIWXNYFD
SUVRPQQEWXURZLVVJVGMPFGLCUVSYAJSDYNO
GYPDJZKBDNDSCNJNLSYSEBCZLLVIZZUZPWKK
WGCQYCHSNYPMPNJOCYYKDGWMSNCVVUPNPRES
EYOOYNKXSIDLTNQXMCNLZQCCGYTICCERLHFF
PLAZPWWVTUTKYXJKOVGOYNJOHIPNPLQPEBGC
SCTOQITCTRVIJYCBDYXOCMKXNYJSDLGWLLMK
MFGNTMCZAYCBLHEOLHFEYYZZPWVOOLGDFLPD
SYTSNBGCSYJKOVTYFAJDMUEUQLQWSCUDCUXO
WMJKOHQGMYEYXYCVZWCVWYIOYXCXOCVGLMRY
AONKCFALPFKOGYFGSUVOGYTDSYQVOZQVVGKQ
SNUKJNJKENJOSCNVLNDKRYPNHUUPFFNYQNWX
YYNCDNWPQYFGTNJDCYCCFLG
""".replace('\n','').lower()
ciphertext = """
yiegwjcqtuufxjrtyaqorvornxwulaxjrvjkqlfxqeekekqakorcmbzmfmpnowepenvvnognfbuicdewboiawjrdyufknrpfnxlaizitzcfpav
"""
#ciphertext= """piuaimsfueglckmfkoujiunmsbzrwgetfmuoeqhkcymzpepvffkyieicfuazmpvcwtmxbrfrikmvmavbvveswumvpmawfmtmitftnvwfrtg"""
#ciphertext = """rzbqukejoqorvccdyhipbqkkmfrowagginihkwhacetkkqmqmcdoswerbfhfrxmglrrvgadlrwhvjlnikqlbpnrrxpqmxpadyitgouxgiixeawxmpxftkyqaieiakmfcgstzaqduvqpaiexiavqakkhuhxqpcqecfgomypckitge"""
#ciphertext = """tjciucejosysncudyhkzcikcmfrqgbyganihmgiscwtkkswrecvoswgbcbhorxmivspvyadltginjdniksvrknvawlkwsgnhmdwomudvnrnlzgcgkwgkhflwjglrfyhgipqaifedfzeehosvofqynuaydcwggkwdqrfwglqwdyhhmwogvane"""
#ciphertext = """jamkyjxzsnyllofvihvzabnmtaokfgryosjtrtvtbauorfdjgatmmsauuhplunbctsmysyfgcurmyjurcyvnucbnsxqoexbbfhrzykmzlq"""
ciphertext = """lwhrfjiebshnknzkjtlmclaiqzbqbycffwsjgivrvhufbxagvgvtbhihniztlfbymqdctkfluhcsovdgrccvgmcyxmaxcmpxttxjxyeke"""
print(find_keylength_candidates_IoC(ciphertext))
#print(find_keylength_candidates_kasiski(ciphertext))
#print(find_keylength(ciphertext))
print(find_keyletters(ciphertext, keylength=9))
#print(vigenere_break(ciphertext))
print(vigenere_decrypt(ciphertext, "minecraft"))
︡a22bb3f5-d4f5-4d33-acb8-c038e0e6844e︡{"stdout":"[18]\n"}︡{"stdout":"utuecrqbx\n"}︡{"stdout":"zoundsizigzaglikeazephyrquietlydownquaintquailstreetwowzaexclaimedzackasizpomedbyquicklystoppingtoexplain\n"}︡{"done":true}
︠bdf3eeb5-0ff3-490f-af26-a9eb90670a9bs︠


︡f9e526ae-0624-4d56-a3a7-51be749b4d0d︡{"done":true}
︠dffbd845-5ca9-4e27-8c1b-95e06da92d5es︠
print(get_key_from_crib("ibziffblttulwifqydtndcyg", "see", 8))
︡b4d03920-4d8d-4906-b537-65892f22c885︡{"stderr":"Error in lines 1-1\nTraceback (most recent call last):\n  File \"/cocalc/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 1188, in execute\n    flags=compile_flags) in namespace, locals\n  File \"\", line 1, in <module>\n  File \"<string>\", line 174, in get_key_from_crib\nNameError: global name 'keyword' is not defined\n"}︡{"done":true}
︠3573265d-ecd2-4ea6-bc86-e2961c7d2e0c︠









