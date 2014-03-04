use utf8;
use Test::Base;
use Text::Md2Inao::TestHelper;

$TODO = '#14';

plan tests => 1 * blocks;
run_is in => 'expected';

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
