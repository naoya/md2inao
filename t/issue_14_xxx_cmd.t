use utf8;
#use Test::Base;
#use Text::Md2Inao::TestHelper;

#plan tests => 1 * blocks;
#run_is in => 'expected';

use Test::More;

pass 'TODO for #14';

done_testing;

__END__
===
--- in md2inao
    ●リスト1 Rubyによる簡易LTSV Parser
    abcd

    !!! cmd
    ●図1 LTSVのParse結果
    abcd
--- expected
◆list/◆
●リスト1 Rubyによる簡易LTSV Parser
abcd
◆/list◆
◆list-white/◆
●図1 LTSVのParse結果
abcd
◆/list-white◆
