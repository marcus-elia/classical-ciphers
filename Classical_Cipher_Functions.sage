# This file contains functions implementing encryption, decryption, and breaking of classical ciphers.

# --------------------------- General Help Functions ---------------------------------------
def just_lower_case(s):
    """ Returns a copy of s where all capitals are lowercase, and any
        non-letters are removed."""
    formatted_s = ""
    for char in s.lower():
        # ignore non-letters
        if char.isalpha():
            formatted_s += char
    return formatted_s



# ---------------------------- The Caesar Shift Cipher ---------------------------------------
def caesar_encrypt(plaintext, shift_amount, formatted=False):
    """ Encrypts the plaintext by shifting each letter of the alphabet forward by shift amount.
        The plaintext must only contain lower case letters, unless formatted=True.
        If formatted=True, then we automatically make everything lower case."""

    ciphertext = ""

    if formatted:
        plaintext = just_lower_case(plaintext)

    for char in plaintext:

        # convert the char to an int
        o = ord(char)

        # check for invalid characters
        if o < 97 or o > 122:
            raise ValueError("Only lower case letters are permitted.")

        # do the encryption
        encrypted_char = ((o - 97 + shift_amount) % 26) + 97

        # convert the int to a char and append it to the ciphertext string
        ciphertext += chr(encrypted_char)
    return ciphertext

def caesar_decrypt(ciphertext, shift_amount):
    """ Decrypts a ciphertext that was encrypted by Caesar."""
    plaintext = ""
    for char in ciphertext:

        # convert the char to an int
        o = ord(char)

        # do the decryption
        decrypted_char = ((o - 97 - shift_amount) % 26) + 97

        # convert the int to a char and append it to the plaintext string
        plaintext += chr(decrypted_char)

    return plaintext

def caesar_break(ciphertext, number_to_show=1):
    """ Breaks the caesar cipher using the index of coincidence.
        If number_to_show is greater than 1, it returns the 2nd best
        option, etc."""
    shift_to_score = {}

    # try shifting the ciphertext backwards by each amount, and compare the result to English
    for i in range(25 + 1):
        shifted = caesar_decrypt(ciphertext, i)
        index = compare_to_language(shifted)
        shift_to_score[i] = index

    # sort such that the closest to English is last
    sorted_values = sorted(shift_to_score, key=shift_to_score.get)

    # get the top results, in descending order
    to_return = sorted_values[-number_to_show:]
    to_return.reverse()
    return to_return

# -------------------------- Frequency Analysis -----------------------------

def frequency(s, target_char, formatted=False):
    """ Returns the number of times that target_char appears in string s"""
    if formatted:
        s = just_lower_case(s)

    count = 0
    for char in s:
        if char == target_char:
            count += 1

    return count

def IoC(s, formatted=False):
    """ Computes the index of coincidence of s.
        s must be entirely lowercase. If formatted=True,
        every capital lowered and every non-letter is ignored."""

    # format the string, if needed
    if formatted:
        s = just_lower_case(s)

    n = len(s)

    # edge cases to avoid a division by zero error
    if n == 0:
        return 0
    if n == 1:
        return 1

    # sum over all lowercase letters
    sum_value = 0
    for i in range(25 + 1):
        F = frequency(s, chr(i + 97))
        sum_value += F*(F - 1)

    return float(sum_value)/((n*(n-1)))

def MIoC(string1, string2, formatted=False):
    """ Returns the mutual index of coincidence between string1 and string2"""
    if formatted:
        string1 = just_lower_case(string1)
        string2 = just_lower_case(string2)

    n = len(string1)
    m = len(string2)

    sum_value = 0
    for i in range(25 + 1):
        F1 = frequency(string1, chr(i+97))
        F2 = frequency(string2, chr(i+97))
        sum_value += F1*F2

    return float(sum_value) / (n*m)

def compare_to_language(s, language="English"):
    """ Computes the MIoC between s and a representative string of the given language."""
    lang_to_string = {"English":"eeeeeeeeeeeetttttttttaaaaaaaaoooooooiiiiiiinnnnnnnssssssrrrrrrhhhhhhddddlllluuucccmmmffyywwggppbbv"}
    return MIoC(s, lang_to_string[language], formatted=True)


# ----------------------------- Vigenere Functions ----------------------------------
def vigenere_encrypt(plaintext, keyword, formatted=False):
    """ Performs Vigenere encryption. Both plaintext and keyword must be
        all lower case. If formatted=True, these will be forced to be lowercase"""
    if formatted:
        plaintext = just_lower_case(plaintext)
        keyword = just_lower_case(keyword)

    # mapping each keyword letter to its 0-25 representative
    index2shift = [ord(char) - 97 for char in keyword]

    ciphertext = ""
    for i in range(len(plaintext)):
        char_value = ord(plaintext[i]) - 97
        ciphertext += chr((char_value + index2shift[i % len(keyword)]) % 26 + 97)

    return ciphertext

def vigenere_decrypt(ciphertext, keyword):
    """ Vigenere decryption."""
    # mapping each keyword letter to its 0-25 representative
    index2shift = [ord(char) - 97 for char in keyword]

    plaintext = ""
    for i in range(len(ciphertext)):
        char_value = ord(ciphertext[i]) - 97
        plaintext += chr((char_value - index2shift[i % len(keyword)]) % 26 + 97)

    return plaintext

def get_key_from_crib(ciphertext, crib, crib_index):
    """ Vigenere cribbing."""
    # mapping each keyword letter to its 0-25 representative
    index2shift = [ord(char) - 97 for char in keyword]
     
    keyletters = ""
    for i in range(len(crib)):
        char_value = ord(crib[i]) - 97
        keyletters += chr((index2shift[(i + crib_index) % len(keyword)] - char_value) % 26 + 97)
    return keyletters

def get_blocks(string, keylength):
    """ Returns a list of blocks, where two characters are in the same
        block if their positions in the string are congruent mod keylength."""
    blocks = [[] for i in range(keylength)]

    # iterate over each character
    for i in range(len(string)):
        j = i % keylength
        blocks[j].append(string[i])

    return blocks

def avg_IoC(ciphertext, keylength):
    """ Returns the average IoC when the ciphertext is broken up into
        keylength different blocks."""
    blocks = get_blocks(ciphertext, keylength)

    # add up the IoC of each block
    IoC_sum = sum([IoC(block) for block in blocks])

    # divide by the number of blocks to get the average
    return IoC_sum / keylength

def find_keylength_candidates_IoC(ciphertext, tolerance=0.055, show_IoCs=False):
    """ Returns a list of potential keylengths that have a high enough
        average IoC. """
    keylength2avgIoC = {}
    for keylength in range(1, len(ciphertext)//4):
        keylength2avgIoC[keylength] = avg_IoC(ciphertext, keylength)

    # return just the keylengths
    if not show_IoCs:
        return [kl for kl in keylength2avgIoC if keylength2avgIoC[kl] > tolerance]

    # return tuples of keylengths and corresponding avg IoC's
    return [(kl, keylength2avgIoC[kl]) for kl in keylength2avgIoC if keylength2avgIoC[kl] > tolerance]

def find_keylength_candidates_kasiski(ciphertext, tolerance=0.045):
    """ Returns a list of potential keylengths from the Kasiski test."""
    trigram2indices = {}
    for i in range(len(ciphertext)-2):

        # the current trigram
        trigram = ciphertext[i:i+3]
        try:
            trigram2indices[trigram].append(i)
        except KeyError:
            trigram2indices[trigram] = [i]
    
    # a list of the differences
    differences = []
    for trigram in trigram2indices:
        current_indices = trigram2indices[trigram]
        if len(current_indices) > 1:
            differences = differences + [current_indices[i] - current_indices[i-1] for i in range(1, len(current_indices))]
    
    # a list of potential keylengths
    to_return = []
    
    # try to find the best "gcd" of the differences
    all_gcd = gcd(differences)
    if all_gcd > 1 and avg_IoC(ciphertext, all_gcd) > tolerance:
        to_return.append(all_gcd)

    # dict counts how many times each pairwise gcd occurs
    pairwisegcd2frequency = {}
    for i in range(len(differences) - 1):
        diff1 = differences[i]
        for diff2 in differences[i+1:]:
            pair_gcd = gcd((diff1, diff2))
            try:
                pairwisegcd2frequency[pair_gcd] += 1
            except KeyError:
                pairwisegcd2frequency[pair_gcd] = 1

    for pair_gcd in pairwisegcd2frequency:
        freq = pairwisegcd2frequency[pair_gcd]
        if freq > 1 and pair_gcd > 1 and avg_IoC(ciphertext, pair_gcd) > tolerance and pair_gcd != all_gcd:
            to_return.append(pair_gcd)
    return to_return

def find_keylength(ciphertext):
    """ Combines the index of coincidence and Kasiski methods to determine
        the keylength. Always returns a single integer."""
    
    # combine the IoC and Kasiski candidates into one list (using set unions)
    IoC_values = find_keylength_candidates_IoC(ciphertext)
    kas_values = find_keylength_candidates_kasiski(ciphertext)
    candidates = list(set(IoC_values).union(set(kas_values)))

    # in case neither algorithm found anything
    if not candidates:
        candidates = find_keylength_candidates_IoC(ciphertext, tolerance = 0.045)
    
    if min(IoC_values) == min(kas_values):
        return min(candidates)
    return min(IoC_values)
    
def find_keyletters(ciphertext, keylength=None):
    """ Given that we can find the keylength, this finds the keyletters. If no 
        key length is specified, we use the find_keylength function."""
    if not keylength:
        kl = find_keylength(ciphertext)
    else:
        kl = keylength
    blocks = get_blocks(ciphertext, kl)
    keyword = ""
    for block in blocks:
        keyword += chr(caesar_break(block)[0] + 97)
    return keyword

def vigenere_break(ciphertext):
    """"""
    return vigenere_decrypt(ciphertext, find_keyletters(ciphertext))